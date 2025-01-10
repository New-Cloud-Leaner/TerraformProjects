# vpc subnet
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.env}-multi-tier-vpc"
  }
}

# public subnet 1
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az1
  tags = {
    Name = "${var.env}-multi-tier-public-subnet"
  }
}
# public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_two
  map_public_ip_on_launch = true
  availability_zone       = var.az2
  tags = {
    Name = "${var.env}-multi-tier-public-subnet"
  }
}

# private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az1
  tags = {
    Name = "${var.env}-multi-tier-private-subnet"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-multi-tier-igw"
  }
}

# public route table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}multi-tier-public-rt"
  }
}

#public route
resource "aws_route" "public" {
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = var.all_traffic_cidr
  route_table_id         = aws_route_table.public_RT.id
}

# public route table association
resource "aws_route_table_association" "public_RT_association" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = aws_subnet.public.id
}

#private RT
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}multi-tier-private-rt"
  }
}

#private RT association
resource "aws_route_table_association" "private_RT_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_RT.id
}