variable "db_secret_arn" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_subnet_group_name" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"  # safer default
}
variable "multi_az" {
  type = bool
}
