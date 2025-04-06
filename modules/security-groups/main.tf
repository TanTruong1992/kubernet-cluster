# Create a security group for Kubernetes cluster
resource "aws_security_group" "k8s_security_group" {
  name        = "${var.cluster_name}-security-group"
  description = "Security group for Kubernetes cluster"
  vpc_id      = var.vpc_id  # Ensure the security group is associated with the correct VPC

  # Ingress rules
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
    description = "Allow Kubernetes API server access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
    description = "Allow HTTPS traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_ranges
    description = "Allow SSH traffic"
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  # Tags for the security group
  tags = merge(
    {
      Name = "${var.cluster_name}-security-group"
    },
    var.additional_tags
  )
}

# Output the security group ID
output "security_group_id" {
  description = "The ID of the Kubernetes security group"
  value       = aws_security_group.k8s_security_group.id
}