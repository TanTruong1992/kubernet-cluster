resource "aws_vpc" "k8s_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "k8s_subnet" {
  count = var.subnet_count
  vpc_id = aws_vpc.k8s_vpc.id
  cidr_block = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment}-subnet-${count.index}"
  }
}

resource "aws_security_group" "k8s_sg" {
  vpc_id = aws_vpc.k8s_vpc.id
  name = "${var.environment}-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-sg"
  }
}

module "ec2_instances" {
  source      = "../../modules/ec2"
  instance_count = var.instance_count
  instance_type  = var.instance_type
  subnet_id      = aws_subnet.k8s_subnet[*].id
  security_group_id = aws_security_group.k8s_sg.id
}

output "vpc_id" {
  value = aws_vpc.k8s_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.k8s_subnet[*].id
}

output "security_group_id" {
  value = aws_security_group.k8s_sg.id
}

output "instance_ids" {
  value = module.ec2_instances.instance_ids
}