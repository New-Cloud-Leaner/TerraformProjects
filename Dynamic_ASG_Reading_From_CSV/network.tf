resource "aws_vpc" "main" {
  cidr_block = var.CIDR_block_vpc
  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.CIDR_block_public1
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Public subnet 1 for main vpc"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.CIDR_block_public2
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "Public subnet 2 for main vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet gateway for public subnet"
  }
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.main.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Public route table rule for IGW"
  }
}

resource "aws_route_table_association" "public_Sub1_assc" {
  route_table_id = aws_route_table.publicRT.id
  subnet_id      = aws_subnet.public1.id
}

resource "aws_route_table_association" "public_Sub2_assc" {
  route_table_id = aws_route_table.publicRT.id
  subnet_id      = aws_subnet.public2.id
}

resource "aws_security_group" "my_web_access_sg" {
  vpc_id = aws_vpc.main.id
  name   = "my-web-access-sg"
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web access SG"
  }
}