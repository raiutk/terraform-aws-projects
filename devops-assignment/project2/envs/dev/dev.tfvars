project_name       = "project2-dev"
s3_bucket_id = "project2-dev-bucket-8f20c475"
aws_region         = "us-east-1"
vpc_id             = "vpc-00233159c7ab7d02d"
public_subnet_ids  = ["subnet-0dd4fb90719426b4c", "subnet-00db50a7a30a5812b"]
private_subnet_ids = ["subnet-005ec7613a733c467", "subnet-0263c052ffb8924ab"]
db_secret_arn      = "arn:aws:secretsmanager:us-east-1:349298600170:secret:project2/db_password-DB1234-9MGHWh"



# RDS instance
db_instance_class  = "db.t3.micro"  # avoid db.t2.micro encryption issue
db_engine          = "mysql"
db_engine_version  = "8.0"
db_name            = "project2db"
db_username        = "dbuser"