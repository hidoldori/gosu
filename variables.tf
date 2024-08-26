#--- root/variables.tf

variable "prefix" { 
  default = "gosu"
  type = string
}

#--- vpc 
variable "vpc_cidr" {
  default = "10.9.0.0/16"
  type = string
}

variable "region" {
  default = "ap-northeast-2"
  type = string
}

#--- subnet
variable "availability_zone" {
  description = "The availability zones to use for subnets and resources in the VPC. By default, all AZs in the region will be used."
  type        = list(string)
  default     = ["ap-northeast-2a","ap-northeast-2c"]
}

variable "public_subnet_cidr" {
  description = "A list of CIDR blocks to use for the public subnets."
  type        = list(string)
  default     = ["10.9.0.0/24","10.9.1.0/24"]
}

variable "private_subnet_cidr" {
  description = "A list of CIDR blocks to use for the private subnets."
  type        = list(string)
  default     = ["10.9.2.0/24","10.9.3.0/24"]
}



