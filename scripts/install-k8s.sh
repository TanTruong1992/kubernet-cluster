#!/bin/bash

# This script installs and configures Kubernetes on an EC2 instance using containerd.
# It supports both master and worker node configurations.

set -euo pipefail  # Enable strict error handling

ROLE=$1  # Accept "master" or "worker" as the first argument to the script
MASTER_IP=${2:-""}  # Master IP for worker nodes
TOKEN=${3:-""}      # Token for worker nodes
CA_CERT_HASH=${4:-""}  # CA certificate hash for worker nodes

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Common setup for both master and worker nodes
echo "Updating package index..."
sudo apt-get update -y

echo "Installing containerd..."
if ! command_exists containerd; then
    sudo apt-get install -y containerd
    sudo mkdir -p /etc/containerd
    containerd config default | sudo tee /etc/containerd/config.toml
    sudo systemctl restart containerd
    sudo systemctl enable containerd
else
    echo "containerd is already installed."
fi

echo "Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "Loading kernel modules..."
sudo modprobe overlay
sudo modprobe br_netfilter

echo "Configuring sysctl settings..."
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

echo "Adding Kubernetes signing key..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Adding Kubernetes repository..."
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo "Installing Kubernetes components..."
if ! command_exists kubeadm || ! command_exists kubectl || ! command_exists kubelet; then
    sudo apt-get update -y
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
else
    echo "Kubernetes components are already installed."
fi

echo "Configuring kubelet to use containerd..."
cat <<EOF | sudo tee /etc/default/kubelet
KUBELET_EXTRA_ARGS="--container-runtime=remote --container-runtime-endpoint=unix:///run/containerd/containerd.sock"
EOF
sudo systemctl restart kubelet

# Master node setup
if [ "$ROLE" == "master" ]; then
    echo "Initializing Kubernetes cluster on the master node..."
    sudo kubeadm init --pod-network-cidr=192.168.0.0/16 || {
        echo "Error: Failed to initialize Kubernetes cluster."
        exit 1
    }

    echo "Setting up kubeconfig for the current user..."
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    echo "Installing Calico pod network add-on..."
    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml || {
        echo "Error: Failed to apply Calico manifest."
        exit 1
    }

    echo "Master node setup complete."

# Worker node setup
elif [ "$ROLE" == "worker" ]; then
    if [ -z "$MASTER_IP" ] || [ -z "$TOKEN" ] || [ -z "$CA_CERT_HASH" ]; then
        echo "Error: Missing required arguments for worker node setup."
        exit 1
    fi

    echo "Joining the Kubernetes cluster as a worker node..."
    sudo kubeadm join "$MASTER_IP:6443" --token "$TOKEN" --discovery-token-ca-cert-hash "sha256:$CA_CERT_HASH" || {
        echo "Error: Failed to join the Kubernetes cluster."
        exit 1
    }

    echo "Worker node joined the cluster successfully."

else
    echo "Error: Invalid role specified. Use 'master' or 'worker'."
    exit 1
fi

echo "Kubernetes installation and configuration completed successfully."