terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "project1_bucket" {
  bucket = var.aws_bucket_name

  tags = {
    Name        = "Project1"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = var.aws_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "block_pub_access" {
  bucket = var.aws_bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
output "new_bucket_id" {
  value = aws_s3_bucket.project1_bucket.id
}
output "new_bucket_name" {
  value = aws_s3_bucket.project1_bucket.arn
}