terraform {
  backend "s3" {
    bucket         = "your-dev-bucket-name"
    key            = "terraform/state/dev/terraform.tfstate"
    region         = "your-region"
    dynamodb_table = "your-dev-lock-table"
    encrypt        = true
  }
}