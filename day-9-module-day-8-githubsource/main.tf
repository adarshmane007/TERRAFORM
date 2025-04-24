module "dev" {
    source = "github.com/adarshmane007/TERRAFORM/day-8-modules-source"
    instance_type ="t2.micro"
    ami_id = "ami-00a929b66ed6e0de6"
    subnet_id = "subnet-07606742f3056653b"
  
}