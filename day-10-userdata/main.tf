resource "aws_instance" "ton" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  key_name = "us-maheshkey"
  availability_zone = "us-east-1a"
  user_data = file("test.sh")
}