terraform {
  backend "s3" {
    bucket         = "your-staging-bucket-name"
    key            = "terraform/state/staging.tfstate"
    region         = "your-region"
    dynamodb_table = "your-dynamodb-table-name"
    encrypt        = true
  }
}