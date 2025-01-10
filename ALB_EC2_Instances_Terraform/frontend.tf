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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPXyC+jQJ14QFyUfipXGd/qnBsUDlG1htfPIOJxXxianFwm4ML7D068pvFys7VwACosJLpZVbdN0mfRLFASOuV/7D58qf3bn9R9k0D70038ipKelIywRvq6I9RJKSsZpT7TpxmOH2SU/rsUZvmh1fEHabVMEFRUKEyDyjzHAgoxbyqyQ/D+YanTpy37J/NGtEZXiIzGnr5hDPKBjfhdTOA4Z1TMFiqBTIKn6UtufqHVLQJz2iFJP06q72L6dDqVDFMI+8zAdMUYiJjXvi808yRobB/w/BiXeDOOePJxk+Q3gdQflCySZ8rdrywr15a7LV5wwC3SNNWkt+r5RR7Pt4CTicsANeGk7GUQMs9njB1tQVGLOQMNr+moiNmLz5UidZupEJLkBvAgrI9FgqvEW5ZKd8e7ZYlV2iQB2MsxWSvyDI8nKs57PXYXcopcrWv8Cva4DWu/qur6V3q0Y6LGBKCnlp+OpyV/127TMmPCWVyXvFkREWGCkXUu1obEKPJz+sLbN5QB8scZt/1BAFoXWkW6ENqdE+4/TDHa8JLAO8ZosYieAzy8ticyWc/UjN24ziaNznLFE0TEfWCKEOu7kv3lscMM10OKfMaJizGUVU5pPp+zzWZXM8VB2qSWbvYCwjVUCg8W1S7YlQ7WUW1F3ELqRf3BrK5H9t6JDPs4j2D5Q== your-email@example.com"
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