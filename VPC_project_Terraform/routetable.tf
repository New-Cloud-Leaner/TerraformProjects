# Rule for RT to route any traffic instead of internal traffic within VPC to go IGW
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_new_vpc.id

  route {
    cidr_block = var.all_traffic_cidr
    gateway_id = aws_internet_gateway.my_igw_vpc.id
  }
  tags = {
    Name        = "Public RT route for IGW"
    Environment = local.Environment
    Owner       = local.Owner
  }
}

# Rule to RT to route any traffic instead of internal traffic within VPC to go NGW

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.my_new_vpc.id

  route {
    cidr_block = var.all_traffic_cidr
    gateway_id = aws_nat_gateway.NGW_vpc.id
  }
  tags = {
    Name        = "Private RT route for NGW"
    Environment = local.Environment
    Owner       = local.Owner
  }
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet_vpc.id
  route_table_id = aws_route_table.private_RT.id
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_rta" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = aws_subnet.public_subnet_vpc.id
}