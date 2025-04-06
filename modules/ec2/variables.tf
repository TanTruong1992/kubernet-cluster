variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.medium"
}

variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instances"
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances in the cluster."
  type        = number
  default     = 3
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the cluster."
  type        = number
  default     = 5
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the cluster."
  type        = number
  default     = 1
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instances"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to apply to the instances"
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}