#scaling policies
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  scaling_adjustment     = local.scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_dynamic_asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in-policy"
  scaling_adjustment     = local.scale_in_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_dynamic_asg.name
}


# CloudWatch Alarm for High CPU Utilization (Scale Up)
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "terraform-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = local.scale_up_threshold
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_dynamic_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

# CloudWatch Alarm for High CPU Utilization (Scale Down)
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "terraform-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = local.scale_in_threshold
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_dynamic_asg.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}