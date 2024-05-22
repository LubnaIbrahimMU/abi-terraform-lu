# Output the private IP address to be used elsewhere
output "private_ip" {
  value = aws_instance.lu_db_t.private_ip
}