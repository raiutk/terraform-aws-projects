/*# Fetch existing VPC from Project 1
data "aws_vpc" "project1" {
  id = var.vpc_id
}

# Fetch public subnets in Project 1 VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project1.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}

# Fetch private subnets in Project 1 VPC
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.project1.id]
  }
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}. */
