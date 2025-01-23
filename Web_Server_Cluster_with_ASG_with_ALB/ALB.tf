resource "aws_lb" "alb_for_asg" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.aws_alb_sg.id]
  subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]
  tags = {
    "Name" = "ALB-FOR-ASG"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_for_asg.arn
  port              = var.http_port
  protocol          = var.http_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener_rule" "asg_listener_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.id
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = "tf-example-lb-tg"
  port     = var.http_port
  protocol = var.http_protocol
  vpc_id   = aws_vpc.example_vpc.id
  health_check {
    path                = "/"
    protocol            = var.http_protocol
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
