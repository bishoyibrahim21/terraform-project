resource "aws_lb" "public_alb" {
  name               = "public-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public-securitygroup-id]
  subnets           = [var.public-subnet-az1-id, var.public-subnet-az2-id]
  tags = {
    "Name" = "bishoy-public-elb"
  }
}

resource "aws_lb_target_group" "public_tg" {
  name     = "public-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}


resource "aws_lb" "private_alb" {
  name               = "private-elb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private-securitygroup-id]
  subnets           = [var.private-subnet-az1-id, var.private-subnet-az2-id]
  tags = {
    "Name" = "bishoy-private-elb"
  }
}

resource "aws_lb_target_group" "private_tg" {
  name     = "private-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}

