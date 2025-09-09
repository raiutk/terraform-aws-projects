# Public subnet IDs by AZ
output "public_subnet_ids" {
  value = { for az, subnet in aws_subnet.public : az => subnet.id }
  description = "Map of public subnet IDs by availability zone"
}

# Private subnet IDs by AZ
output "private_subnet_ids" {
  value = { for az, subnet in aws_subnet.private : az => subnet.id }
  description = "Map of private subnet IDs by availability zone"
}