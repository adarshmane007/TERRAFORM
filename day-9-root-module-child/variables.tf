#RDS variables
variable "identifier" {
  description = "Database instance identifier"
  type        = string
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class (e.g., db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "username" {
  description = "Master username"
  type        = string
}
variable "major_engine_version" {
  description = "The major engine version for the RDS option group (e.g., 13 for PostgreSQL)"
  type        = string
}

variable "family" {
  description = "The family for the RDS parameter group (e.g., postgres13)"
  type        = string
}
variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "vpc_security_group_ids" {
  description = "List of VPC Security Group IDs"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot on deletion"
  type        = bool
  default     = true
}
#LAMBDA variables
variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "source_path" {
  description = "Path to the Lambda function source code"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function (example: index.handler)"
  type        = string
}

variable "runtime" {
  description = "Runtime for the Lambda function (example: nodejs14.x)"
  type        = string
}

variable "package_type" {
  description = "Deployment package type (Zip or Image)"
  type        = string
}