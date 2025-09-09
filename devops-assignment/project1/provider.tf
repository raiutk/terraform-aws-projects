terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "project1/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
