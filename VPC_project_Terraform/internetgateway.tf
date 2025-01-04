#Internet gateway for the VPC for internet access for public subnet resouces
resource "aws_internet_gateway" "my_igw_vpc" {
  vpc_id = aws_vpc.my_new_vpc.id

  tags = {
    Name        = "IGW for the VPC"
    Environment = local.Environment
    Owner       = local.Owner
  }
}