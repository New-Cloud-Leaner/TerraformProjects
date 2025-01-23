output "aws_autoscaling_group_arn" {
  description = "autoscaling arn"
  value       = aws_autoscaling_group.example_ASG.arn
}
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.example_vpc.id
}
output "subnet_ids_public_subnet1" {
  description = "subnet 1 ID"
  value       = aws_subnet.public1.id
}
output "subnet_ids_public_subnet2" {
  description = "subnet 2 ID"
  value       = aws_subnet.public2.id
}
output "alb_dns_name" {
  value       = aws_lb.alb_for_asg.dns_name
  description = "Domain name of ALB"
}