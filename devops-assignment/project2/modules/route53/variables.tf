variable "project_name" {
  type        = string
  description = "Project name for tagging resources"
}

variable "domain_name" {
  type        = string
  description = "Domain name for Route53"
}

variable "alb_dns_name" {
  type        = string
  description = "DNS name of the ALB"
}

variable "alb_zone_id" {
  type        = string
  description = "Hosted zone ID of the ALB"
}
