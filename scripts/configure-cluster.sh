#!/bin/bash

# This script configures the Kubernetes cluster after installation.

set -euo pipefail  # Enable strict error handling

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure kubectl is installed
if ! command_exists kubectl; then
    echo "Error: kubectl is not installed. Please install it and try again."
    exit 1
fi

# Set the Kubernetes context to the newly created cluster
echo "Setting Kubernetes context to 'my-cluster'..."
kubectl config use-context my-cluster || {
    echo "Error: Failed to set Kubernetes context. Ensure the cluster is configured correctly."
    exit 1
}

# Install the necessary networking add-ons (e.g., Calico)
echo "Installing Calico networking add-on..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml || {
    echo "Error: Failed to apply Calico manifest."
    exit 1
}

# Set up the Kubernetes dashboard
echo "Deploying Kubernetes dashboard..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml || {
    echo "Error: Failed to deploy Kubernetes dashboard."
    exit 1
}

# Create a service account for the dashboard
echo "Creating service account and cluster role binding for the dashboard..."
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard || {
    echo "Error: Failed to create service account."
    exit 1
}
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin || {
    echo "Error: Failed to create cluster role binding."
    exit 1
}

# Get the access token for the dashboard
echo "Retrieving access token for the Kubernetes dashboard..."
DASHBOARD_SECRET=$(kubectl get serviceaccount dashboard-admin -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}")
if [ -z "$DASHBOARD_SECRET" ]; then
    echo "Error: Failed to retrieve dashboard secret."
    exit 1
fi

DASHBOARD_TOKEN=$(kubectl get secret "$DASHBOARD_SECRET" -n kubernetes-dashboard -o jsonpath="{.data.token}" | base64 --decode)
if [ -z "$DASHBOARD_TOKEN" ]; then
    echo "Error: Failed to decode dashboard token."
    exit 1
fi

echo "Dashboard access token:"
echo "$DASHBOARD_TOKEN"

# Print instructions for accessing the dashboard
echo "Kubernetes dashboard is deployed. Access it using the following command:"
echo "kubectl proxy"
echo "Then navigate to: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login"
