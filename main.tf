##vpc

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr_a = "10.0.1.0/24"
  public_subnet_cidr_b = "10.0.2.0/24"
  private_subnet_cidr  = "10.0.3.0/24"
  availability_zone    = "us-east-1a"
  availability_zone2   = "us-east-1b"
  vpc_id               = module.vpc.vpc_id
  lb_security_group_id = module.vpc.lb_sg_id

}







module "asg" {
  source               = "./modules/asg"
  image_id             = var.image_id
  template_name        = var.template_name
  instance_type        = var.instance_type
  public_subnet_ids    = module.vpc.public_subnet_ids
  vpc_id               = module.vpc.vpc_id
  wordpress_sg_id      = module.vpc.wordpress_sg_id
  lb_security_group_id = module.vpc.lb_sg_id
  subnets              = module.vpc.public_subnet_ids
  key_name             = module.ec2.key
  private_key_pem      = module.ec2.private_key_pem
  user_data            = base64encode(file("./install.sh"))
  depends_on           = [module.ec2]
  # depends_on                = [null_resource.update_docker_compose]

}

module "ec2" {
  source            = "./modules/ec2"
  image_id2         = var.image_id2
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id
  private_ip        = module.ec2.private_ip
  key               = module.ec2.key


}

resource "null_resource" "update_docker_compose" {
  provisioner "local-exec" {
    command = "bash ./update_docker_compose.sh"
  }

  # Trigger the execution whenever there's a change in the frontend EC2 instance
  triggers = {
    when_frontend_ec2_private_ip_changed = module.ec2.instance_id
  }

  # Ensure the execution order is respected
  depends_on = [module.ec2]
}