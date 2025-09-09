variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_secret_arn" {
  type = string
}

variable "s3_bucket_id" {
  description = "The name of the S3 bucket to use as CloudFront origin"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "RDS database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "RDS database engine version"
  type        = string
  default     = "8.0"
}


variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

