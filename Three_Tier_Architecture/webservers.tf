resource "aws_key_pair" "key" {
  key_name   = "three-tier-key"
  public_key = "ssh YOUR PRIVATE KEY or PATH to file here using file module"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "webserver" {
  count           = 3
  instance_type   = "t2.micro"
  ami             = data.aws_ami.ubuntu.id
  subnet_id       = element(aws_subnet.private_subnet[*].id, count.index)
  security_groups = [aws_security_group.web_sg.id]
  key_name        = aws_key_pair.key.key_name
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              echo "Welcome to Web Server $(hostname)" > /var/www/html/index.html
            EOF
  depends_on      = [aws_nat_gateway.private_natgw]
  tags = {
    Name = "webserver-${count.index}"
  }
}
