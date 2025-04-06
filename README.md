# terraform-k8s-cluster/README.md

# Terraform Kubernetes Cluster on AWS EC2

This project provides a Terraform configuration to deploy a self-managed Kubernetes cluster on AWS EC2. It is structured into modules for better organization and reusability.

## Project Structure

- **modules/**: Contains reusable Terraform modules.
  - **ec2/**: Module for provisioning EC2 instances.
  - **vpc/**: Module for creating a Virtual Private Cloud (VPC).
  - **security-groups/**: Module for managing security groups.

- **environments/**: Contains environment-specific configurations.
  - **dev/**: Development environment configuration.
  - **staging/**: Staging environment configuration.
  - **prod/**: Production environment configuration.

- **scripts/**: Contains scripts for setting up and configuring the Kubernetes cluster.
  - **install-k8s.sh**: Script to install Kubernetes on EC2 instances.
  - **configure-cluster.sh**: Script to configure the Kubernetes cluster.

- **main.tf**: Root Terraform configuration file that ties together all modules and resources.

- **variables.tf**: Input variables for the overall project.

- **outputs.tf**: Outputs for the overall project.

## Getting Started

1. **Prerequisites**: Ensure you have Terraform installed and configured with your AWS credentials.

2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd terraform-k8s-cluster
   ```

3. **Select Environment**: Navigate to the desired environment folder (e.g., `environments/dev`).

4. **Initialize Terraform**:
   ```bash
   terraform init
   ```

5. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

6. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

## Modules Documentation

- **EC2 Module**: See `modules/ec2/README.md` for details on how to use the EC2 module.
- **VPC Module**: See `modules/vpc/README.md` for details on how to use the VPC module.
- **Security Groups Module**: See `modules/security-groups/README.md` for details on how to use the security groups module.

## Scripts

- **install-k8s.sh**: Automates the installation of Kubernetes on the EC2 instances.
- **configure-cluster.sh**: Configures the Kubernetes cluster after installation.

## Outputs

After deployment, the following outputs will be available:
- Cluster endpoint
- Node information

## License

This project is licensed under the MIT License. See the LICENSE file for details.