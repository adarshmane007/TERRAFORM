resource "aws_key_pair" "name" {
  key_name = "us-maheshkeyv2"
  public_key =file("~/.ssh/id_ed25519.pub")
}


# IAM Policy for S3 access
resource "aws_iam_policy" "s3_access_policy" {
  name        = "EC2S3AccessPolicy"
  description = "Policy for EC2 instances to access S3"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::tiktikt",
          "arn:aws:s3:::tiktikt/*"
        ]
      }
    ]
  })
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

#attach policy to role
# Attach policy to role
resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}




# create an instance profile for the role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_s3_access_instance_profile"
  role = aws_iam_role.ec2_role.name

}


#ec2 instance
resource "aws_instance" "nullserver" {
  ami                  = "ami-00a929b66ed6e0de6" 
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.name.key_name
  security_groups      = ["default"]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  

  tags = {
    Name = "nullserver"
  }
}

# Null resource to run remote commands on the instance
 resource "null_resource" "setup_and_upload" {
  depends_on = [aws_instance.nullserver]

  provisioner "remote-exec" {
    inline = [
      # Install Apache
      "sudo yum install -y httpd",

      # Install AWS CLI
      "sudo yum install -y awscli",

      # Start Apache
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",

      # Create index.html
      "sudo mkdir -p /var/www/html/",
      "echo '<h1>Welcome to My Web Server</h1>' | sudo tee /var/www/html/index.html",

      # Upload file to S3
      "aws s3 cp /var/www/html/index.html s3://tiktikt/",
      "echo 'File uploaded to S3'"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_ed25519")
    host        = aws_instance.nullserver.public_ip
  }

   triggers = {
    always_run = timestamp()
  }
} 

      
  
  
