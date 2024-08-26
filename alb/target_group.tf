#--- target-group.tf


resource "aws_lb_target_group" "this" {

  name = "${var.prefix}-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc-id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "this" {
  count = length(var.instance-ids)

  target_group_arn = aws_lb_target_group.this.arn
  target_id = "${var.instance-ids[count.index]}"
  port = 80
}
