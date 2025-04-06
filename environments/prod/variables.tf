variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the cluster"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances in the cluster"
  type        = number
  default     = 3
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the cluster nodes"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "The CIDR blocks that are allowed to access the Kubernetes API"
  type        = list(string)
}