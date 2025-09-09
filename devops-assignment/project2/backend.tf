terraform {
  backend "s3" {
    bucket         = "project2-terraform-backend02041713"  # same bucket name as above
    key            = "project2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project2-terraform-lock"
    encrypt        = true
  }
}
