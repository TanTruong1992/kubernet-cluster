# General cluster configuration
variable "cluster_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., production, staging, dev)"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

# SSH key pair
variable "keypair_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
}

# Master node configuration
variable "master_instance_type" {
  description = "Instance type for the master node"
  type        = string
}

# Worker node configuration
variable "worker_instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes to deploy"
  type        = number
}

# Networking configuration
variable "allowed_ip_ranges" {
  description = "CIDR blocks allowed to access the cluster"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# AMI configuration
variable "ami" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}