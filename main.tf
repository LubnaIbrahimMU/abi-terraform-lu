##vpc

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidr_a  = "10.0.1.0/24"
  public_subnet_cidr_b  = "10.0.2.0/24"
  private_subnet_cidr   = "10.0.3.0/24"
  availability_zone     =  "us-east-1a"
  availability_zone2    = "us-east-1b"
  vpc_id   = module.vpc.vpc_id
  lb_security_group_id = module.vpc.lb_sg_id
  
}


# output "public_subnet_ids" {
#   value = module.vpc.public_subnet_ids
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "private_subnet_id" {
#   value = module.vpc.private_subnet_id
# }

# output "wordpress_sg_id" {
#   value = module.vpc.wordpress_sg_id
# }

# output "lb_security_group_id" {
#   value = module.vpc.lb_sg_id
# }




module "asg" {
  source = "./modules/asg"
  image_id = var.image_id
  template_name = var.template_name
  instance_type = var.instance_type
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id   = module.vpc.vpc_id
  wordpress_sg_id     = module.vpc.wordpress_sg_id
  lb_security_group_id = module.vpc.lb_sg_id
  subnets     = module.vpc.public_subnet_ids

 }


