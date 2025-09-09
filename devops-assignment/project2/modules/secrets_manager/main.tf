data "aws_secretsmanager_secret_version" "db" {
  secret_id = var.db_secret_arn
}

output "db_credentials" {
  value = data.aws_secretsmanager_secret_version.db.secret_string
}
