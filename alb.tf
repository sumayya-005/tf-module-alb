resource "aws_lb" "internal" {
name               = "${var.env}-${var.name}-internal"
internal           = true
load_balancer_type = "application"
security_groups    = [aws_security_group.internal.id]
subnets            = var.private_subnets

   tags = {
      Name = "${var.env}-${var.name}-internal"
  }
}

resource "aws_security_group" "internal" {
name        = "${var.env}-${var.name}-internal-alb.sg"
description = "${var.env}-${var.name}-internal-alb.sg"
vpc_id      = var.vpc_id

 ingress {
   description = "HTTP"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = [var.vpc_cidr]
}


 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
}


  tags = {
    Name = "${var.env}-${var.name}internal-alb.sg"
}
}

#resource "aws_lb_listener" "main" {
#count             = var.internal ? 1 : 0
#load_balancer_arn = aws_lb.main.arn
#port              = "80"
#protocol          = "HTTP"
#
#default_action {
#type = "fixed-response"
#
#fixed_response {
#content_type = "text/plain"
#message_body = "Fixed response content"
#status_code  = "200"
#}
#}
#}
#
#resource "aws_lb_listener" "public-http" {
#count             = var.internal ? 0 : 1
#load_balancer_arn = aws_lb.main.arn
#port              = "80"
#protocol          = "HTTP"
#
#default_action {
#type = "redirect"
#
#redirect {
#port        = "443"
#protocol    = "HTTPS"
#status_code = "HTTP_301"
#}
#}
#}