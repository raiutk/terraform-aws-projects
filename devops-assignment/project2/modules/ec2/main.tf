#######################################################
# IAM Instance Profile (to attach IAM role to EC2)
#######################################################
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = var.ec2_role_name
}

#######################################################
# EC2 Instance
#######################################################
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOT
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>Hello from ${var.project_name} EC2 instance</h1>" > /var/www/html/index.html
              systemctl enable httpd
              systemctl start httpd
              EOT

  tags = {
    Name = "${var.project_name}-ec2"
  }
}

#######################################################
# ALB Target Group Attachment
#######################################################
resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.app.id
  port             = 8080
}
