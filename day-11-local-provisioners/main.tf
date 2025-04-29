resource "aws_key_pair" "example" {
  key_name   = "us-maheshkeyv2"  # Replace with your desired key name
  public_key =file("~/.ssh/id_ed25519.pub")

}

resource "aws_instance" "ton" {
    ami = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    key_name = "us-maheshkey"

  provisioner "local-exec" {
    command = "echo instance created ! >> output.tf"
    
  }
}

