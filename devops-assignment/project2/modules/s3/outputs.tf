output "s3_bucket_name" {
  value = aws_s3_bucket.project_bucket.id
  description = "Name of the S3 bucket"
}
