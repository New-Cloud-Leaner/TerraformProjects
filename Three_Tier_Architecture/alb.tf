resource "aws_alb" "app_lb" {
  name                       = "three-tier-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = aws_subnet.public_subnet[*].id
  enable_deletion_protection = false
  tags = {
    Name = "three-tier-alb"
  }
}
resource "aws_alb_target_group" "web_TG" {
  name     = "three-tier-tg"
  port     = var.HTTP_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "three-tier-tg"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = var.HTTP_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web_TG.arn
  }
}

resource "aws_alb_target_group_attachment" "web_attach" {
  count            = 3
  target_group_arn = aws_alb_target_group.web_TG.id
  target_id        = aws_instance.webserver[count.index].id
  port             = var.HTTP_port
}