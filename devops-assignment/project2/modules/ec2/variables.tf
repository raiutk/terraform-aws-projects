variable "project_name" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "ec2_role_name" {}          # IAM role for EC2
variable "alb_target_group_arn" {}   # Attach EC2 to ALB
variable "ami_id" {
  default = "ami-00ca32bbc84273381"  # Amazon Linux 2 in ap-south-1
}
variable "instance_type" {
  default = "t2.micro"
}
