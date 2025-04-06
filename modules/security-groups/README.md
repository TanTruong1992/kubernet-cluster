# Security Groups Module

This module is responsible for creating and managing security groups in AWS for the Kubernetes cluster. It defines the necessary inbound and outbound rules to ensure proper communication between the cluster nodes and external resources.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "security_groups" {
  source = "../modules/security-groups"

  allowed_ip_ranges = var.allowed_ip_ranges
  protocols         = var.protocols
}
```

## Inputs

| Name              | Description                                   | Type          | Default | Required |
|-------------------|-----------------------------------------------|---------------|---------|:--------:|
| allowed_ip_ranges  | List of allowed IP ranges for inbound rules   | list(string)  | []      | yes      |
| protocols         | List of protocols to allow (e.g., tcp, udp)  | list(string)  | []      | yes      |

## Outputs

| Name               | Description                                   |
|--------------------|-----------------------------------------------|
| security_group_ids | List of security group IDs created by this module |