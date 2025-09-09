terraform {
  required_version = ">=1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = "10.0.0.0/16"
  environment = "dev"
}

module "subnets" {
  source = "../../modules/subnets"
  vpc_id = module.vpc.vpc_id
  environment = "dev"
  public_subnets  = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
  private_subnets = {
    "us-east-1a" = "10.0.101.0/24"
    "us-east-1b" = "10.0.102.0/24"
  }
}

module "route_tables" {
  source = "../../modules/route_tables"
  vpc_id = module.vpc.vpc_id
  environment = "dev"
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
  environment = "dev"
  allowed_ingress_cidrs = ["0.0.0.0/0"]
}

module "vpc_endpoints" {
  source = "../../modules/vpc_endpoints"
  vpc_id = module.vpc.vpc_id
  environment = "dev"
  region = var.aws_region
  private_route_table_ids = module.route_tables.private_rt_ids
}
