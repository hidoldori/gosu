# --- public_route_table.tf
# route table creation
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.prefix}-public-rt"
    Managed_by = "terraform"
  }
}

#add route to go to the internet gateway for public
resource "aws_route" "internet_gateway" {
   route_table_id = aws_route_table.public.id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.this.id
}

#subnet association
resource "aws_route_table_association" "public" {
   count = length(var.public_subnet_cidr)
   
   subnet_id = "${aws_subnet.public-subnet[count.index].id}"
   route_table_id = aws_route_table.public.id
}

