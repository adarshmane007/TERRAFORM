resource "aws_instance" "new" {
    instance_type = var.instance_type
    ami = var.ami_id
    subnet_id = var.subnet_id
  
}