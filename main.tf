provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnets = {
    "subnet1" = { cidr = "10.0.1.0/24", az = "ap-south-1a" }
    "subnet2" = { cidr = "10.0.2.0/24", az = "ap-south-1b" }
  }
  vpc_name = "Project_VPC"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  security_groups = {
    "ec2_sg" = {
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress_rules = [
        {
          to_port     = 0,
          from_port   = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
    "alb_sg" = {
      ingress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress_rules = [{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }]
    }
  }
}

module "ec2" {
  source            = "./modules/ec2"
  instance_type     = "t2.micro"
  key_name          = "my-manual-key"
  security_group_id = module.security_groups.security_groups_ids["ec2_sg"]
  subnets = {
    "instance1" = module.vpc.public_subnets["subnet1"]
    "instance2" = module.vpc.public_subnets["subnet2"]
  }
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = values(module.vpc.public_subnets)
  alb_security_group_id = module.security_groups.security_groups_ids["alb_sg"]
  ec2_instance_ids      = module.ec2.instance_ids
}

module "cloudfront"{
  source = "./modules/cloudfront"
  alb_dns_name = module.alb.alb_dns_name
}