# This file defines the outputs for the security group module.
# Output the ID of the security group

output "security_group_id" {
  value = aws_security_group.k8s_security_group.id
}

# Output the ARN of the security group

output "security_group_arn" {
  value = aws_security_group.k8s_security_group.arn
}
