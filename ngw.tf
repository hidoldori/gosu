#--- ngw.tf
resource "aws_eip" "this" {
   vpc = true

   tags = {
      Name = "${var.prefix}-eip"
      Managed_by = "terraform"
   }
   depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
   allocation_id = aws_eip.this.id
   subnet_id = aws_subnet.public-subnet[0].id
   
   tags = {
      Name = "${var.prefix}-nat-gw"
      Managed_by = "terraform"
   }
   depends_on = [aws_internet_gateway.this]
}

