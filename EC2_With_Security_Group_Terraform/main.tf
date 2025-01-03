#AWS EC2 resource for creation of EC2 instance with a t3.micro

resource "aws_instance" "web" {
  ami           = var.ami_for_ec2
  instance_type = var.instance_family
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "web vm"
    Environment = "dev"
  }
}

# Security group resource with SSH ingress and allow all outbound traffic rule

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_rule" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = var.ssh_cidr
  from_port         = var.ssh_port
  ip_protocol       = "tcp"
  to_port           = var.ssh_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = var.ssh_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
}
