output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = { for k, v in aws_subnet.public : k => v.id }
}

output "route_table_id" {
  value = aws_route_table.public.id
}