resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "lu-tf"
  public_key = tls_private_key.pk.public_key_openssh

#   provisioner "local-exec" 

  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.pk.private_key_pem}' > ./lu-tf.pem"
  # }


#   provisioner "local-exec" {
#   command = <<EOT
#     rm -f ./lu-tf.pem
#     echo '${tls_private_key.pk.private_key_pem}' > ./lu-tf.pem
#   EOT
# }


provisioner "local-exec" {
  command = <<EOT
    rm -f ./lu-tf.pem
    echo '${tls_private_key.pk.private_key_pem}' > ./lu-tf.pem
    chmod 400 ./lu-tf.pem
  EOT
}




}