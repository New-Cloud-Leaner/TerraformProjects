output "aws_ec2_instance_id" {
  value = aws_instance.web.id
}

output "aws_ec2_instance_arn" {
  value = aws_instance.web.arn
}

output "aws_ec2_instance_id_pip" {
  value = aws_instance.web.public_ip
}