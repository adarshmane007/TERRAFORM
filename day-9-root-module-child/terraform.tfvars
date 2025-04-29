# RDS Variables
identifier = "mydb-instance1"
engine = "mysql"
engine_version = "8.0"
instance_class = "db.t3.micro"
allocated_storage = 20
username = "admin"
password = "Password@123"
family = "mysql8.0"
major_engine_version = "8.0"


vpc_security_group_ids = ["sg-00ecb9b8b4344511e"]
db_subnet_group_name = "dbsubgrp"
skip_final_snapshot = true        

# Lambda Variables
function_name = "my_lambda_function"
handler        = "index.handler"                # Depends on your code setup
runtime        = "nodejs14.x"                   # Example: python3.11, nodejs18.x, etc.
source_path = "./lambda_code"             
package_type = "Zip"