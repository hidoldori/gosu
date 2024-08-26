# --- route_table.tf
# route table creation
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.prefix}-private-rt"
    Managed_by = "terraform"
  }
}

#add route to go to the internet gateway for public
resource "aws_route" "nat_gateway" {
   route_table_id = aws_route_table.private.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.this.id
}

#subnet association
resource "aws_route_table_association" "private" {
   count = length(var.private_subnet_cidr)
   
   subnet_id = "${aws_subnet.private-subnet[count.index].id}"
   route_table_id = aws_route_table.private.id
}

