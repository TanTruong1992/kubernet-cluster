variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to use for the nodes"
  type        = string
  default     = "t2.medium"
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