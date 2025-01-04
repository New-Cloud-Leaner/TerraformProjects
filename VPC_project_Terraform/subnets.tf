#addition of the public subnet for the vpc
resource "aws_subnet" "public_subnet_vpc" {
  vpc_id                  = aws_vpc.my_new_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name        = "Public Subnet for VPC"
    Environment = local.Environment
    Owner       = local.Owner
  }
}

#addition of private subnet for the vpc
resource "aws_subnet" "private_subnet_vpc" {
  vpc_id     = aws_vpc.my_new_vpc.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name        = "Private Subnet for VPC"
    Environment = local.Environment
    Owner       = local.Owner
  }
}