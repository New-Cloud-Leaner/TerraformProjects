#ALB Security group
resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "alb-sg-"
  ingress {
    description = "allow HTTP traffic"
    from_port   = var.HTTP_port
    to_port     = var.HTTP_port
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic_cidr]
  }
  egress {
    description = "allow all traffic outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_traffic_cidr]
  }
  tags = {
    Name = "${var.env}-alb-sg"
  }
}

# ALB target group
resource "aws_lb_target_group" "frontend-tg" {
  name        = "frontend-target-group"
  vpc_id      = aws_vpc.main.id
  port        = var.HTTP_port
  target_type = "instance"
  protocol    = "HTTP"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.env}-frontend-tg"
  }
}

# ALB Target group attachment to instances 
resource "aws_lb_target_group_attachment" "frontend_attachment" {
  count            = length(aws_instance.frontend)
  target_group_arn = aws_lb_target_group.frontend-tg.arn
  target_id        = aws_instance.frontend[count.index].id
  port             = var.HTTP_port
}

# Application Load Balancer
resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public.id,aws_subnet.public_subnet_2.id]
  tags = {
    Name = "${var.env}-frontend-alb"
  }
}

#ALB listner

resource "aws_lb_listener" "frontend_listner" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = var.HTTP_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-tg.arn
  }
}