variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_a" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.2.0/24"
}


variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.3.0/24"
}


variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone2" {
  description = "The availability zone for the subnets"
  type        = string
  default     = "us-east-1b"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}


variable "lb_security_group_id" {
  description = "Security group ID for the Load Balancer"
  type        = string
}



