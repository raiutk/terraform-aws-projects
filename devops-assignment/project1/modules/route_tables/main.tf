# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnets with Public RT
resource "aws_route_table_association" "public_assoc" {
  for_each       = var.public_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# NAT Gateway in each public subnet
resource "aws_eip" "nat" {
  for_each = var.public_subnet_ids
  tags = {
    Name        = "${var.environment}-nat-eip-${each.key}"
    Environment = var.environment
  }
}


resource "aws_nat_gateway" "nat" {
  for_each = var.public_subnet_ids
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value
  tags = {
    Name        = "${var.environment}-nat-${each.key}"
    Environment = var.environment
  }
}

# Private Route Tables
resource "aws_route_table" "private" {
  for_each = var.private_subnet_ids
  vpc_id   = var.vpc_id
  tags = {
    Name        = "${var.environment}-private-rt-${each.key}"
    Environment = var.environment
  }
}

# Route for Private Subnets via NAT
resource "aws_route" "private_nat_route" {
  for_each             = var.private_subnet_ids
  route_table_id        = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id        = aws_nat_gateway.nat[each.key].id
}

# Associate Private Subnets with Private RT
resource "aws_route_table_association" "private_assoc" {
  for_each       = var.private_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}
