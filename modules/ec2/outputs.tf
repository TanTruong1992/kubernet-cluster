
output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.k8s_instance[*].id
}

output "public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.k8s_instance[*].public_ip
}

output "private_ips" {
  description = "The private IPs of the EC2 instances"
  value       = aws_instance.k8s_instance[*].private_ip
}

output "instance_states" {
  description = "The states of the EC2 instances"
  value       = aws_instance.k8s_instance[*].instance_state
}

