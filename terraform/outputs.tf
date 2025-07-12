
output "load_balancer_dns" {
  description = "DNS name of the ALB"
  value       = aws_lb.medusa_alb.dns_name
}
