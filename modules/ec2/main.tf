data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  for_each        = var.subnets
  ami             = data.aws_ami.latest_amazon_linux.id
  instance_type   = var.instance_type
  subnet_id       = each.value
  key_name        = var.key_name
  security_groups = [var.security_group_id]
  user_data = base64encode(
    <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Project 1 - CloudFront with ALB and EC2!</h1>" | sudo tee /var/www/html/index.html
              EOF
  )
  tags = {
    Name = "WebServer${each.key}"
  }
}

