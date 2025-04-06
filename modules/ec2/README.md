# File: /terraform-k8s-cluster/terraform-k8s-cluster/modules/ec2/README.md

# EC2 Module for Kubernetes Cluster

This module provisions EC2 instances required for a self-managed Kubernetes cluster on AWS. It allows you to define the necessary parameters for creating and managing EC2 resources.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "ec2" {
  source     = "../modules/ec2"
  instance_type = var.instance_type
  ami          = var.ami
  key_name     = var.key_name
  subnet_id    = var.subnet_id
  ...
}
```

## Input Variables

| Name          | Description                                   | Type   | Default | Required |
|---------------|-----------------------------------------------|--------|---------|:--------:|
| instance_type | The type of EC2 instance to create            | string |         |   yes    |
| ami           | The AMI ID to use for the EC2 instance       | string |         |   yes    |
| key_name      | The name of the key pair to use               | string |         |   yes    |
| subnet_id     | The ID of the subnet to launch the instance in| string |         |   yes    |

## Outputs

| Name          | Description                                   |
|---------------|-----------------------------------------------|
| instance_id   | The ID of the created EC2 instance           |
| public_ip     | The public IP address of the EC2 instance     |

## Example

Here is an example of how to call this module:

```hcl
module "ec2" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  ami           = "ami-0c55b159cbfafe1f0"
  key_name      = "my-key-pair"
  subnet_id     = "subnet-0bb1c79de3EXAMPLE"
}
```

Make sure to replace the values with your specific configurations.