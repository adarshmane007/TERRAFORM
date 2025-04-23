resource "aws_db_instance" "dev" { 
  allocated_storage       = 10
  identifier              = "book-rds"
  db_name                 = "database1"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "admin123"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0"
  provider                = aws.primary
  backup_retention_period = 7
  backup_window           = "12:00-13:00"
  monitoring_interval     = 60  
  monitoring_role_arn     = aws_iam_role.rds_monitoring.arn
  maintenance_window      = "sun:04:00-sun:05:00" 
  deletion_protection     = true
  skip_final_snapshot     = true
}

#iam role for rds enhanced monitoring

resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  provider = aws.primary
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring

resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
    provider   = aws.primary
    role       = aws_iam_role.rds_monitoring.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

#subnet group for db

resource "aws_db_subnet_group" "sub-grp" {
    name = "dbsubgrp"
    subnet_ids = ["subnet-0c20ce10dc2cb4f54" ,"subnet-07606742f3056653b"]
    provider = aws.primary
    tags = {
      Name= "mydbsubgrp"
    }
}

#read replica 
resource "aws_db_instance" "read_replica" {
    provider = aws.secondary
    identifier = "book-rds-replica"
    replicate_source_db = aws_db_instance.dev.arn
    instance_class = "db.t3.micro"
    db_subnet_group_name = aws_db_subnet_group.secondary_region_group.name
    publicly_accessible = true
    depends_on = [aws_db_instance.dev]
    skip_final_snapshot = true
    final_snapshot_identifier = "read-replica-snapshot-${formatdate("YYYYMMDDhhmmss", timestamp())}"

}

#subnet group for replica

resource "aws_db_subnet_group" "secondary_region_group" {
    provider = aws.secondary
    name = "seconary-subnet-group"
    subnet_ids = ["subnet-03e6a567fdc452fcd" ,"subnet-0d1d38715f6df4320"]
    tags = {
      Name= "seconary-subnet-group"
    }
}