#-- root/modules.tf

module "s3" {
  source   = "./s3"
  prefix = var.prefix
}

module "ec2" {
  source   = "./ec2"
  prefix = var.prefix # variables.tf 선언된 변수 	
  availability_zone = var.availability_zone # variables.tf 선언된 변수 
  public-subnet = aws_subnet.public-subnet #생성된 subnet 정보 

  security-groups-admin = aws_security_group.admin
}

module "alb" {
  
  #--- alb 
  source = "./alb"
  prefix = var.prefix
  security-groups-alb = aws_security_group.alb
  public-subnet-ids = [for subnet in aws_subnet.public-subnet : subnet.id]

  #--- target-group
  vpc-id = aws_vpc.this.id
  instance-ids = module.ec2.ec2-nginx 
}
