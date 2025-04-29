# RDS
module "rds" {
  source                  = "./RDS/terraform-aws-rds"
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
   major_engine_version = var.major_engine_version
  family               = var.family
  allocated_storage       = var.allocated_storage
  username                = var.username
  password                = var.password
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  skip_final_snapshot     = var.skip_final_snapshot
}

# LAMBDA
module "lam" {
  source = "./LAMBDA/terraform-aws-lambda"

  function_name = var.function_name
  source_path   = var.source_path
  handler       = var.handler
  runtime       = var.runtime
  package_type  = var.package_type
}

