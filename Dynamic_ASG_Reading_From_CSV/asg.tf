# launch template

resource "aws_launch_template" "asg_template" {
  name          = "asg-launch-template"
  instance_type = var.instance_type
  image_id      = var.ami
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.my_web_access_sg.id]
  }
}

resource "aws_autoscaling_group" "my_dynamic_asg" {
  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }
  min_size            = local.min_size
  max_size            = local.max_size
  desired_capacity    = local.desired_capacity
  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]
}