# VPC Module README

# VPC Module

This module is responsible for creating a Virtual Private Cloud (VPC) in AWS. It sets up the necessary networking components required for deploying resources in a secure and isolated environment.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "vpc" {
  source          = "../modules/vpc"
  cidr_block      = var.cidr_block
  availability_zones = var.availability_zones
}
```

## Inputs

| Name                | Description                                   | Type           | Default | Required |
|---------------------|-----------------------------------------------|----------------|---------|----------|
| `cidr_block`        | The CIDR block for the VPC                    | `string`       | n/a     | yes      |
| `availability_zones`| List of availability zones for subnets        | `list(string)` | n/a     | yes      |

## Outputs

| Name        | Description                      |
|-------------|----------------------------------|
| `vpc_id`    | The ID of the created VPC       |
| `subnet_ids`| The IDs of the created subnets   |

## Example

Here is an example of how to use this module in your Terraform configuration:

```hcl
module "vpc" {
  source              = "../modules/vpc"
  cidr_block          = "10.0.0.0/16"
  availability_zones  = ["us-east-1a", "us-east-1b"]
}
```

This will create a VPC with the specified CIDR block and subnets in the given availability zones.