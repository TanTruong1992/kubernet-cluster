variable "instance_type" {
  description = "The type of EC2 instance to use for the Kubernetes nodes."
  default     = "t2.medium"
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the instances."
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instances will be launched."
}

variable "desired_capacity" {
  description = "The desired number of EC2 instances in the Kubernetes cluster."
  default     = 3
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the Kubernetes cluster."
  default     = 5
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the Kubernetes cluster."
  default     = 1
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instances will be launched."
}