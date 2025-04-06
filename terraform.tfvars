# General cluster configuration
cluster_prefix              = "kuber-tech01"                # Prefix for naming resources
region                      = "ap-southeast-1"              # AWS region for deployment
environment                 = "production"                  # Environment (e.g., production, staging, dev)
owner                       = "team-name"                   # Owner of the resources

# SSH key pair
keypair_name                = "kuberlab01"                  # SSH key pair name for EC2 instances

# Master node configuration
master_instance_type        = "t3.small"                    # Instance type for the master node
master_instance_name        = "master"                      # Name for the master node instance

# Worker node configuration
worker_instance_type        = "t3.small"                    # Instance type for the worker nodes
worker_instance_name        = "worker"                      # Name for the worker node instances
number_of_workers           = 3                             # Number of worker nodes to deploy

# Networking configuration
allowed_ip_ranges           = ["0.0.0.0/0"]                 # CIDR blocks allowed to access the cluster
availability_zones          = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"] # Availability zones
public_subnet_cidrs         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]             # Public subnet CIDRs
private_subnet_cidrs        = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]                        # Private subnet CIDRs

# AMI configuration
ami                         = "ami-12345678"                # AMI ID for the EC2 instances