variable "project_name" {
  type        = string
  description = "Project name for naming resources"
}

variable "s3_bucket_id" {
  type        = string
  description = "S3 bucket ID to serve as CloudFront origin"

  
}

variable "aws_region" {
  description = "AWS region where the S3 bucket exists"
  type        = string
}