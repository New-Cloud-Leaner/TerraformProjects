resource "aws_security_group" "frontend-sg" {
  name_prefix = "frontend-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "allow HTTP"
    to_port     = var.HTTP_port
    from_port   = var.HTTP_port
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic_cidr]
  }
  ingress {
    description = "allow SSH"
    to_port     = var.SSH_port
    from_port   = var.SSH_port
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic_cidr]
  }
  egress {
    description = "allow all traffic"
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = [var.all_traffic_cidr]
  }
  tags = {
    Name = "${var.env}-frontend-sg"
  }
}
# EC2 keypair
resource "aws_key_pair" "frontend_key" {
  key_name   = "${var.env}-key"
  public_key = "ssh-rsa YOUR PUBLIC KEY HERE"
}

# ec2-instances-frontend
resource "aws_instance" "frontend" {
  instance_type   = var.instance_type
  count           = 3
  ami             = var.ec2_ami
  subnet_id       = aws_subnet.public.id
  key_name        = aws_key_pair.frontend_key.id
  security_groups = [aws_security_group.frontend-sg.id]
  # User Data for Apache Installation
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Welcome to Frontend Web Server Instance ${count.index + 1}</h1>" > /var/www/html/index.html
  EOF
  tags = {
    Name = "${var.env}-frontend-ec2-${count.index}"
  }
}
