
# Fetch DB credentials from Secrets Manager
data "aws_secretsmanager_secret_version" "db" {
  secret_id = var.db_secret_arn
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)
}

#######################################################
# IAM Module
#######################################################
module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  vpc_id       = var.vpc_id
}

#######################################################
# S3 Module
#######################################################
module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  aws_region   = var.aws_region
}

#######################################################
# ALB Module
#######################################################
module "alb" {
  source         = "./modules/alb"
  project_name   = var.project_name
  vpc_id         = var.vpc_id
  public_subnets = var.public_subnet_ids
  alb_sg_id      = module.iam.alb_sg_id
}

#######################################################
# RDS Module
#######################################################
module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  db_subnet_ids        = var.private_subnet_ids
  db_subnet_group_name = "${var.project_name}-db-subnet-group"
  sg_id                = module.iam.rds_sg_id
  db_secret_arn        = var.db_secret_arn
  multi_az             = false
  allocated_storage    = 20
  db_instance_class = "db.t3.micro"
}

#######################################################
# EC2 Module
#######################################################
module "ec2" {
  source               = "./modules/ec2"
  project_name         = var.project_name
  subnet_id            = var.private_subnet_ids[0]
  sg_id                = module.iam.ec2_sg_id
  ec2_role_name        = split("/", module.iam.ec2_role_arn)[1]
  alb_target_group_arn = module.alb.app_tg_arn
}

#######################################################
# CloudFront Module
#######################################################
module "cloudfront" {
  source       = "./modules/cloudfront"
  project_name = var.project_name
  s3_bucket_id = module.s3.s3_bucket_name
   aws_region   = var.aws_region  
   depends_on   = [module.s3] 
}

#######################################################
# Route53 Module
#######################################################
module "route53" {
  source       = "./modules/route53"
  project_name = var.project_name
  domain_name  = "example.com"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

#######################################################
# Outputs
#######################################################
output "vpc_id" {
  value = var.vpc_id
}

output "public_subnets" {
  value = var.public_subnet_ids
}

output "private_subnets" {
  value = var.private_subnet_ids
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}
