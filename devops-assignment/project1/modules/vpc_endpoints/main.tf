resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
  tags = {
    Name        = "${var.environment}-s3-endpoint"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
  tags = {
    Name        = "${var.environment}-dynamodb-endpoint"
    Environment = var.environment
  }
}
