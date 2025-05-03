resource "aws_key_pair" "my_key" {
  key_name   = "my-key2"
  public_key = file("C:/Users/Adarsh/.ssh/id_ed25519.pub")
}
