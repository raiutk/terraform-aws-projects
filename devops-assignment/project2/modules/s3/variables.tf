
variable "project_name" {
  description = "Project name for naming the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the S3 bucket"
  type        = string
  default     = "us-east-1"
}
