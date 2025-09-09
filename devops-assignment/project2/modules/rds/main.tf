

data "aws_secretsmanager_secret_version" "db" {
  secret_id = var.db_secret_arn   
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)
}

resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids
  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  instance_class       = var.db_instance_class
  db_name                 = "${replace(var.project_name, "-", "_")}_db"
  username             = local.db_credentials.username
  password             = local.db_credentials.password
  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name = aws_db_subnet_group.this.name
  multi_az             = var.multi_az
  storage_encrypted    = true
  skip_final_snapshot  = true
}

output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}
