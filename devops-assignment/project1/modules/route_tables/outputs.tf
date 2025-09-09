output "public_rt_id" {
  value = aws_route_table.public.id
}

output "private_rt_ids" {
  value = [for rt in aws_route_table.private : rt.id]
}
