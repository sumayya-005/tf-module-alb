resource "aws_lb" "main" {
  name               = "${var.env}-${var.name}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets


  tags = {
    Name = "${var.env}-${var.name}"
  }
}

resource "aws_security_group" "main" {
  name        = "${var.env}-${var.name}-alb.sg"
  description = "${var.env}-${var.name}-alb.sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.internal ? [var.vpc_cidr] : ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-alb.sg"
  }
}