resource "aws_s3_bucket" "project_bucket" {
  bucket = "${var.project_name}-bucket-${random_id.suffix.hex}"  # unique name
  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.project_name
  }
}

# Public access block
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.project_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.project_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.project_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Random suffix for globally unique bucket name
resource "random_id" "suffix" {
  byte_length = 4
}
