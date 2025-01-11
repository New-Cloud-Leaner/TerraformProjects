resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "three-tier-vpc"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "three-tier-igw"
  }
}
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zone, count.index)
  tags = {
    Name = "three-tier-public-subnet-${count.index}"
  }
}
resource "aws_subnet" "private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(["10.0.3.0/24", "10.0.4.0/24"], count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "three-tier-private-subnet-${count.index}"
  }
}
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "three-tier-public-rt"
  }
}
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_RT_asso" {
  count          = length(aws_subnet.public_subnet[*].id)
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags = {
    Name = "three-tier-nat-eip"
  }
}

resource "aws_nat_gateway" "private_natgw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "three-tier-nat-gateway"
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.main.id
  route {
    gateway_id = aws_nat_gateway.private_natgw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "three-tier-private-RT"
  }
}

resource "aws_route_table_association" "private_RT_asso" {
  route_table_id = aws_route_table.private_RT.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
  count          = length(aws_subnet.private_subnet[*].id)
}