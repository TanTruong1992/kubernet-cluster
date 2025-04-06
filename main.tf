# VPC Module
module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  name                = var.cluster_prefix
  region              = var.region
  tags = {
    Name        = var.cluster_prefix
    Environment = var.environment
    Owner       = var.owner
  }
  enable_dns_support              = true
  enable_dns_hostnames            = true
  enable_internet_gateway         = true
  enable_nat_gateway              = true
  availability_zones              = var.availability_zones
  public_subnet_cidrs             = var.public_subnet_cidrs
  private_subnet_cidrs            = var.private_subnet_cidrs
}

# Security Group for Kubernetes Cluster
module "security_groups" {
  source           = "./modules/security-groups"
  vpc_id           = module.vpc.vpc_id
  allowed_ip_ranges = var.allowed_ip_ranges
  cluster_name     = var.cluster_prefix
  additional_tags  = {
    Environment = var.environment
    Owner       = var.owner
  }
}

# Deploy the Master Node
module "master_instance" {
  source            = "./modules/ec2"
  instance_type     = var.master_instance_type
  key_name          = var.keypair_name
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.security_group_id
  ami               = var.ami
  instance_count    = 1

  user_data = templatefile("${path.module}/scripts/install-k8s.sh.tpl", {
    role = "master"
  })

  additional_tags = {
    Role        = "master"
    Environment = var.environment
    Owner       = var.owner
  }
}

# Deploy Worker Nodes
module "worker_instances" {
  source            = "./modules/ec2"
  instance_type     = var.worker_instance_type
  key_name          = var.keypair_name
  subnet_id         = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.security_group_id
  ami               = var.ami
  instance_count    = var.worker_count

  user_data = templatefile("${path.module}/scripts/install-k8s.sh.tpl", {
    role = "worker"
  })

  additional_tags = {
    Role        = "worker"
    Environment = var.environment
    Owner       = var.owner
  }
}

# Configure the Kubernetes Cluster
resource "null_resource" "configure_cluster" {
  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/configure-cluster.sh"
  }

  depends_on = [
    module.master_instance,
    module.worker_instances
  ]
}

# Configure kubectl on the Master Node
resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/configure-kubectl.sh"
  }

  depends_on = [
    module.master_instance
  ]
}

# Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_groups.security_group_id
}

output "master_instance_id" {
  description = "The ID of the master instance"
  value       = module.master_instance.instance_ids
}

output "worker_instance_ids" {
  description = "The IDs of the worker instances"
  value       = module.worker_instances.instance_ids
}

output "worker_public_ips" {
  description = "The public IPs of the worker nodes"
  value       = module.worker_instances.public_ips
}

output "worker_private_ips" {
  description = "The private IPs of the worker nodes"
  value       = module.worker_instances.private_ips
}

output "worker_instance_states" {
  description = "The states of the worker instances"
  value       = module.worker_instances.instance_states
}


