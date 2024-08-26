#--- security-group.tf

#nginx
resource "aws_security_group" "admin" {
   name = "${var.prefix}-amin-sg"
   vpc_id = aws_vpc.this.id

   # Outbound ALL
   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-admin-sg"
      Managed_by = "terraform"
   }

} 

resource "aws_security_group_rule" "admin-ssh" {
   description = "Allow SSH from admin"
   type = "ingress"

   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks       = ["0.0.0.0/0"]
   security_group_id = aws_security_group.admin.id
}

resource "aws_security_group_rule" "frontend-http" {
  description = "Allow HTTP from admin"
  type              = "ingress"

  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.admin.id
}


#alb
resource "aws_security_group" "alb" {
   name = "${var.prefix}-alb-sg"
   vpc_id = aws_vpc.this.id

   # Outbound ALL
   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "${var.prefix}-alb-sg"
      Managed_by = "terraform"
   }

} 

resource "aws_security_group_rule" "alb-http" {
  description = "Allow HTTP from alb"
  type              = "ingress"

  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}
