#!/bin/bash

# filepath: /c:/Users/nguye/OneDrive/Aws/kubernet-terraform-build/terraform-k8s-cluster/scripts/configure-kubectl.sh

set -euo pipefail  # Enable strict error handling

export HOME=/home/ubuntu
echo "START configure-kubectl.sh"

# Install kubectx and kubens
echo "Installing kubectx and kubens..."
if [ ! -d /opt/kubectx ]; then
    sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
    sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -sf /opt/kubectx/kubens /usr/local/bin/kubens
else
    echo "kubectx and kubens are already installed."
fi

# Install fzf (fuzzy finder)
echo "Installing fzf..."
if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
else
    echo "fzf is already installed."
fi

# Configure aliases for kubectl
echo "Configuring kubectl aliases..."
cat << 'EOF' >> ~/.bashrc
# kubectx and kubens
export PATH=~/.kubectx:$PATH

# Kubectl Aliases
alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"
alias kns="kubectl get namespaces"
alias kgn="kubectl get nodes"
alias kgno="kubectl get nodes -o wide"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods -A"
alias kgpo="kubectl get pods -o wide"
alias kgpy="kubectl get pods -o yaml"
alias kgcmy="kubectl get configmap -o yaml"
alias kgcm="kubectl get configmap"
alias kecm="kubectl edit configmap"
alias kesec="kubectl edit secret"
alias kexe="kubectl exec -it"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias kgi="kubectl get ingress"
alias kgiy="kubectl get ingress -o yaml"
alias kgs="kubectl get services"
alias kgsa="kubectl get services -A"
alias kgsec="kubectl get secret"
alias kgsecy="kubectl get secret -o yaml"
alias kgd="kubectl get deployment"
alias kgda="kubectl get deployment -A"
alias kgdy="kubectl get deployment -o yaml"
alias ked="kubectl edit deployment"
alias kdelp="kubectl delete pod"
EOF

# Configure kubectl auto-completion
echo "Configuring kubectl auto-completion..."
cat << 'EOF' >> ~/.bashrc
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
EOF

# Reload bashrc
source ~/.bashrc

# Install Helm
echo "Installing Helm..."
if ! command -v helm &> /dev/null; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm -f get_helm.sh
else
    echo "Helm is already installed."
fi

echo "Configuration completed successfully!"