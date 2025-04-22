#vpc
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
}
 
#I.G
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.dev.id
}

#elastic ip
resource "aws_eip" "nat_eip" {
  
}

#NAT G
resource "aws_nat_gateway" "NAT" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public.id
  
}

#subnet
resource "aws_subnet" "public" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.dev.id
    availability_zone ="us-east-1a"
  
}

resource "aws_subnet" "private" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.dev.id
     availability_zone ="us-east-1b"
  
}

#public route table
resource "aws_route_table" "PRT" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }

  tags = {
    Name = "Public Route Table"
  }
}


# subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.PRT.id
  
}

#private RT
resource "aws_route_table" "PVT" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# subnet association
resource "aws_route_table_association" "subp" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.PVT.id
  
}

#public server
resource "aws_instance" "publicserver" {
    ami = "ami-00a929b66ed6e0de6"
    subnet_id = aws_subnet.public.id
    instance_type = "t2.micro"
    tags = {
      Name="publicI"
    }
  
}

#private server
resource "aws_instance" "privateserver" {
    ami = "ami-0e449927258d45bc4"
    subnet_id = aws_subnet.private.id
    instance_type = "t2.micro"
    tags = {
      Name="privateI"
    }
  
}

#security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.dev.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

}
