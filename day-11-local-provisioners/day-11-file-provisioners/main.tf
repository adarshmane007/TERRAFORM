resource "aws_key_pair" "example" {
  key_name   = "us-maheshkeyv2"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "ton" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name

  #  Connection block for SSH
  connection {
    type        = "ssh"
    user        = "ec2-user"  # Use 'ubuntu' for Ubuntu AMIs
    private_key = file("~/.ssh/id_ed25519")  # Private key path
    host        = self.public_ip
  }

  #  file provisioner
  provisioner "file" {
   source ="file10" 
   destination = "/home/ec2-user/file10"
    
  }
}

