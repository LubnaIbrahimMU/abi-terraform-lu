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


variable "image_id" {
  type = string
}
variable "template_name" {
  type = string
}

variable "instance_type" {
  type = string
}


variable "image_id2" {
  type = string
}


