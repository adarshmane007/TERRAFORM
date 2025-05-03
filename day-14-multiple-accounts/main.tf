# first configure keys in TERRAFORM folder

#1 aws configure --profile dev
//acess key
//secret key
//region

#2 aws configure --profile prod
//acess key
//secret key
//region

#3 aws configure --profile staging
//acess key
//secret key
//region



#in main.tf file
//resource "aws_instance" "ton" {
//   ami = "ami-0e449927258d45bc4"
// profile = aws.account1
//   instance_type = "t2.micro" 
//}
