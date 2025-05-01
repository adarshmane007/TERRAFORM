#usecase-1 / 2 instance create - dev-0 , dev-1

//resource "aws_instance" "name" {
  //ami = "ami-0e449927258d45bc4"
  //instance_type = "t2.micro"
  //key_name = "us-maheshkey"
  //count = 2

  //tags = {
    //Name= "dev-${count.index}"
  //}
//}

#usecase-2 different name 

#variable "env" {
   // type = list(string)
   // default = [ "dev","tets","prod" ]
                     
  
//}
//resource "aws_instance" "name" {
 // ami = "ami-0e449927258d45bc4"
 // instance_type = "t2.micro"
 // key_name = "us-maheshkey"
 // count = length(var.env)

 //tags = {
     // Name = var.env[count.index]
   // }
//}