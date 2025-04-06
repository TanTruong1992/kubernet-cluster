output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = module.k8s.cluster_endpoint
}

output "node_ips" {
  description = "The public IPs of the worker nodes"
  value       = module.worker_instances.public_ips
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "security_group_ids" {
  description = "The IDs of the security groups"
  value       = module.security_groups.security_group_ids
}

output "master_instance_ids" {
  description = "The IDs of the master instance"
  value       = module.master_instance.instance_ids
}

output "worker_instance_ids" {
  description = "The IDs of the worker instances"
  value       = module.worker_instances.instance_ids
}

output "worker_public_ips" {
  description = "The public IPs of the worker instances"
  value       = module.worker_instances.public_ips
}

output "worker_private_ips" {
  description = "The private IPs of the worker instances"
  value       = module.worker_instances.private_ips
}