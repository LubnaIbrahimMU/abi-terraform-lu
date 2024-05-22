#Create DB EC2
resource "aws_instance" "lu_db_t" {

  ami                         = var.image_id2
  instance_type               = "t2.micro"
  subnet_id                   = var.private_subnet_id
  key_name                    = "lu-tf"
  vpc_security_group_ids      = ["${aws_security_group.mysql_sg.id}"]
  

          
#   provisioner "local-exec" {
#     command = "echo ${self.private_ip} > private_ip.txt"
#   }


  # Using the local-exec provisioner to run a shell command locally to write the private IP to a file
  provisioner "local-exec" {
    command = "echo private_ip = ${self.private_ip} > private_ip.txt"
  }
      


  tags = {
    Name = "lu-db-t"
  }

}