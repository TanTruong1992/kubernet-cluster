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
    Name = "${var.environment}-subnet-${count.index + 1}"
  }
}

module "security_groups" {
  source = "../../modules/security-groups"
  environment = var.environment
}

module "ec2" {
  source = "../../modules/ec2"
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.k8s_subnet[count.index].id
  count = var.instance_count
}

output "vpc_id" {
  value = aws_vpc.k8s_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.k8s_subnet[*].id
}

output "instance_ids" {
  value = module.ec2.instance_ids
}