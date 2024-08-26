#--- ec2/ec2_nginx.tf

resource "aws_instance" "this" {
  count = length(var.availability_zone)

  associate_public_ip_address = true
  ami = data.aws_ami.this.id
  subnet_id = var.public-subnet[count.index].id
  instance_type          = "t2.micro"
  user_data = file("${path.module}/userdata.sh")

  vpc_security_group_ids = [var.security-groups-admin.id]

  tags = {
    Name = "${var.prefix}-nginx-${count.index+1}"
    Managed_by = "terraform"
  }
}  
