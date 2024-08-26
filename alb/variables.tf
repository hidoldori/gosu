#--- ec2/variables.tf

#-- alb
variable "prefix" {} 
variable "public-subnet-ids" {}
variable "security-groups-alb" {}

#-- target-group
variable "instance-ids" {}
variable "vpc-id" {}

