output "vpc_id" {
  value = aws_vpc.abi-lu.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public-lu1.id,
    aws_subnet.public-lu2.id
  ]
}

output "private_subnet_id" {
  value = aws_subnet.private-lu1.id
}


output "wordpress_sg_id" {
  description = "ID of the security group for WordPress instances"
  value       = aws_security_group.wordpress_sg.id
}


output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}


