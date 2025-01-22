output "vpc_id" {
  value = aws_vpc.main.id
}
output "subnet_ids" {
  value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "launch_template_id" {
  value = aws_launch_template.asg_template.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.my_dynamic_asg.arn
}

output "autoscaling_min" {
  value = aws_autoscaling_group.my_dynamic_asg.min_size
}

output "autoscaling_max" {
  value = aws_autoscaling_group.my_dynamic_asg.max_size
}

output "autoscaling_desired_capacity" {
  value = aws_autoscaling_group.my_dynamic_asg.desired_capacity
}