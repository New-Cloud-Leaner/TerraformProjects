resource "aws_launch_template" "asg_template" {
  name          = "asg-launch-template"
  instance_type = var.instance_type_ec2
  image_id      = var.ami_id
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.aws_alb_sg.id]
  }
    user_data = base64encode(<<-EOT
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Welcome to My Website</h1>" > /var/www/html/index.html
  EOT
  )
}

resource "aws_autoscaling_group" "example_ASG" {
  name = "terraform-upnrunning-ch2-proj3-web-cluster-ASG"
  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]
  target_group_arns   = [aws_lb_target_group.front_end.arn]

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "terraform-asg-upnrunning-web-cluster-ch1-project3"
    propagate_at_launch = true
  }
}


