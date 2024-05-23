# Output the private IP address to be used elsewhere
output "private_ip" {
  value = aws_instance.lu_db_t.private_ip

}

output "key" {
  value = aws_key_pair.key
}



output "private_key_pem" {
  value     = tls_private_key.pk.private_key_pem
  sensitive = true
}


output "instance_id" {
  value = aws_instance.lu_db_t.id
  
}