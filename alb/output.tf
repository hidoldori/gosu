# ---- alb/outputs.tf

output "alb" {
  value = aws_lb.this.name
}
