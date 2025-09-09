variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "allowed_ingress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
