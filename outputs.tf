output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "wordpress_sg_id" {
  value = module.vpc.wordpress_sg_id
}

output "lb_security_group_id" {
  value = module.vpc.lb_sg_id
}



output "asg_name" {
  value = module.asg.asg_name
}


output "load_balancer_dns_name" {
  value = module.asg.load_balancer_dns_name
}
