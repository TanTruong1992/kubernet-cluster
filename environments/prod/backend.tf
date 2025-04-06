terraform {
  backend "s3" {
    bucket         = "your-prod-bucket-name"
    key            = "prod/terraform.tfstate"
    region         = "your-region"
    dynamodb_table = "your-prod-lock-table"
    encrypt        = true
  }
}