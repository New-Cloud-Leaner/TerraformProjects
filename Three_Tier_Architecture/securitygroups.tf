resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    description = "Allow HTTP traffic from anywhere"
    from_port   = var.HTTP_port
    to_port     = var.HTTP_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all traffic to webserver"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = [for subnet in aws_subnet.private_subnet : subnet.cidr_block]
  }
  tags = {
    Name = "three-tier-alb-sg"
  }
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = var.HTTP_port
    to_port     = var.HTTP_port
    protocol    = "tcp"
    cidr_blocks = [for subnet in aws_subnet.public_subnet : subnet.cidr_block]
  }
  egress {
    description = "allow all egress traffic to db server"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = [for subnet in aws_subnet.private_subnet : subnet.cidr_block]
  }
  egress {
    description = "allow all egress traffic for internet to get updates"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "three-tier-web-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = var.RDS_port
    to_port     = var.RDS_port
    protocol    = "tcp"
    cidr_blocks = [for subnet in aws_subnet.private_subnet : subnet.cidr_block]
  }
  egress {
    description = "allow all traffic egress"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "three-tier-rds-sg"
  }
}