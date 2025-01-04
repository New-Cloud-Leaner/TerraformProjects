output "vpc_id" {
  value = aws_vpc.my_new_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_vpc.id
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.NGW_vpc.id
}