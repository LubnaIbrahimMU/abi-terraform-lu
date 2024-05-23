output "asg_name" {
  value = aws_autoscaling_group.lu.name
}


output "load_balancer_dns_name" {
  value = aws_lb.lb_lu.dns_name
}


# output "public_ip" {
#   value = aws_instance.wordpress_lu.public_ip

# }


# data "aws_instances" "asg_instances" {
#   instance_tags = {
#     Name = "wordpress_lu"
#   }
#   depends_on = [aws_autoscaling_group.lu]
# }


# output "instance_public_ips" {
#   value = data.aws_instances.asg_instances
# }



data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Name"
    values = ["lu-wordpress"]
  }
  depends_on = [aws_autoscaling_group.lu]
}

output "instance_public_ips" {
  value = data.aws_instances.asg_instances.public_ips
}
