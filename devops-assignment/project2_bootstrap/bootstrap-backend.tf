
resource "aws_s3_bucket" "tf_backend" {
  bucket = "project2-terraform-backend02041713"  # Use a globally unique name

  tags = {
    Name        = "Project2 Terraform Backend"
    Environment = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "tf_backend_block" {
  bucket                  = aws_s3_bucket.tf_backend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "project2-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Project2 Terraform Lock Table"
    Environment = "Terraform"
  }
}

output "s3_backend_bucket" {
  value = aws_s3_bucket.tf_backend.id
}

output "dynamodb_lock_table" {
  value = aws_dynamodb_table.tf_lock.name
}
