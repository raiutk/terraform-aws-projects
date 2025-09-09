resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-public-${each.key}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-private-${each.key}"
    Environment = var.environment
  }
}
