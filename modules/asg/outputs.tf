output "asg_name" {
  value = aws_autoscaling_group.lu.name
}


output "load_balancer_dns_name" {
  value = aws_lb.lb_lu.dns_name
}
