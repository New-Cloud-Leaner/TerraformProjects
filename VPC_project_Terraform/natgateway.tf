# Public IP address for the NAT gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT gateway for Private Subnets to gain access to the internet via Egress traffic
resource "aws_nat_gateway" "NGW_vpc" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_vpc.id

  tags = {
    Name        = "NAT GW"
    Environment = local.Environment
    Owner       = local.Owner
  }
}