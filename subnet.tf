resource "aws_subnet" "public-subnet" {
  count                   = length(var.public_subnet_cidr)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]

  tags = {
    Name = "public-subnet_${count.index + 1}"
    Managed_by = "terraform"
  }
}

resource "aws_subnet" "private-subnet" {
  count                   = length(var.private_subnet_cidr)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = var.availability_zone[count.index]

  tags = {
    Name = "private-subnet_${count.index + 1}"
    Managed_by = "terraform"
  }
}
