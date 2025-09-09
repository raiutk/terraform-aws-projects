variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}
