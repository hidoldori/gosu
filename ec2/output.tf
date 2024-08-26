# ---- ec2/outputs.tf

output "ec2-nginx" {
  value = aws_instance.this[*].id
}
