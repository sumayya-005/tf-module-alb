output"lb_dns_name" {
  value = aws_lb.main.dns_name
}

output "lb_listener" {
  value = aws_lb_listener.main.arn
}