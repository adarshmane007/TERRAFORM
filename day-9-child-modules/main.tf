# for ec2
module "ec2" {
    source = "./modules/ec2-instance"
    ami = var.ami
    subnet_id = var.subnet_id
    security_group_ids = var.security_group_ids
    key_name = var.key_name
    name = var.ec2_name
}

#s3
module "s3" {
    source = "./modules/s3"
    enable_versioning = var.enable_versioning
    environment = var.environment
  
}
