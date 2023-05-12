resource "aws_lb" "public" {
  name               = "${var.env}-${var.name}-public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets            = var.public_subnets

  tags = {
    Name = "${var.env}-${var.name}-public"
  }
}

resource "aws_security_group" "public" {
  name        = "${var.env}-${var.name}-public-alb.sg"
  description = "${var.env}-${var.name}-public-alb.sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "${var.env}-${var.name}-public-alb.sg"
  }
}
