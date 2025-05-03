variable "create_instance" {
  description = "Boolean flag to control EC2 creation"
  type        = bool
  default     = false
}

resource "aws_instance" "my_ec24" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-0e449927258d45bc4" 
  instance_type = "t2.micro"

  tags = {
    Name = "Conditional-EC2"
  }
}