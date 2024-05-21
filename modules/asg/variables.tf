variable "image_id" {
  type        = string
}
variable "template_name" {
  type        = string
}

variable "instance_type" {
  type        = string
}




variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}



variable "wordpress_sg_id" {
  description = "ID of the security group for WordPress instances"
  type        = string
}

variable "lb_security_group_id" {
  description = "Security group ID for the Load Balancer"
  type        = string
}




variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}






variable "subnets" {
  description = "The subnets for the load balancer"
  type        = list(string)
}


