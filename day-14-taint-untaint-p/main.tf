
# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyVPC"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "MySubnet"
  }
}

# Create an EC2 instance inside the subnet
resource "aws_instance" "my_ec2" {
  ami           = "ami-0f88e80871fd81e91" # Replace with the appropriate AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id

  tags = {
    Name = "MyEC2Instance"
  }
}


#terraform taint command
//terraform taint aws_instance.my_ec2

#terraform untaint command
//terraform untaint aws_instance.my_ec2

#terraform replace command
//terraform apply -replace aws_instance.my_ec2