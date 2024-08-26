#--- alb/alb.tf

resource "aws_lb" "this" {
  name = "${var.prefix}-alb"

  internal = false
  
  load_balancer_type = "application"

  security_groups = [var.security-groups-alb.id]
  subnets = var.public-subnet-ids
  tags = {
    Name = "${var.prefix}-alb"
    Managed_by = "terraform"
  }
}  

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
