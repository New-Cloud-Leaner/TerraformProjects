# locals block for common tags

locals {
  service_name = "stage-servers"
  owner        = "application team"
  environment  = "stage"
}

# Fetch the AMI ID of the ubuntu image

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Resource block for EC2 instance to create 3 EC2 instances
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count         = 3
  tags = {
    Name         = "ec2-instance-${count.index}"
    service_name = local.service_name
    owner        = local.owner
    environment  = local.environment
  }
}