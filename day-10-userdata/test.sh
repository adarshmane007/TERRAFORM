#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to my website hosted on EC2!</h1>" > /var/www/html/index.html
