# ---- vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.this.id
}
output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "aws_security_group_admin" {
  value = aws_security_group.admin.id
}

output "aws_security_group_alb" {
  value = aws_security_group.alb.id
}

output "public-subnet-ids" {
   value = [for subnet in aws_subnet.public-subnet : subnet.id]
}
/*
output "public-subnet" {
  value = aws_subnet.public-subnet
}

output "private-subnet" {
  value = aws_subnet.private-subnet
}
*/
/*
output "s3_bucket_id" {
  value = module.s3.s3_bucket_id 
}*/
/*
output "ec2-nginx" {
  value = module.ec2.ec2-nginx
}*/

output "alb" {
  value = module.alb
}
