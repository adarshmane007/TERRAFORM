variable "ami" {
  type    = string
  default = "ami-0e449927258d45bc4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type    = list(string)
  default = ["one","three"]
}

resource "aws_instance" "tan" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.env)
#   count = length(var.env)  

  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }
}