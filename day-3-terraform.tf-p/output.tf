output "ip" {
    value = aws_instance.dev.public_ip
  
}
output "subnet_id" {
    value = aws_instance.dev.subnet_id
  
}
output "security" {
    value = aws_instance.dev.vpc_security_group_ids
    sensitive = true
  
}