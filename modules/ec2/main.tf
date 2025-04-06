# Create EC2 instances for Kubernetes
resource "aws_instance" "k8s_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id] # Link to the reusable security group

  tags = merge(
    {
      Name = "${var.cluster_name}-instance-${count.index + 1}"
    },
    var.additional_tags
  )
}

# Outputs
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