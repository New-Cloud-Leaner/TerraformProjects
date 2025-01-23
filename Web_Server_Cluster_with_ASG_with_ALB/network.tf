resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_CIDR
  tags = {
    "Name" = "ASG_VPC"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.publicsubnet1
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    "Name" = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.publicsubnet2
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    "Name" = "Public-Subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    "Name" = "Internet Gateway for public subnet"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "Public-RT-table"
  }
}

resource "aws_route_table_association" "public-RT-assc1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "public-RT-assc2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "aws_alb_sg" {
  vpc_id = aws_vpc.example_vpc.id
  name   = "ALB for the ASG"
  tags = {
    "Name" = "ALB-for-ASG"
  }
  ingress {
    to_port     = var.http_port
    from_port   = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
}
