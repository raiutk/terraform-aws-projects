# route53/main.tf

# Create a private hosted zone for dev/testing
resource "aws_route53_zone" "main" {
  name = "${var.project_name}.dev.local"  # dev environment domain
}

# Create an A record pointing to the ALB
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.project_name}.dev.local"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
