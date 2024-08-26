#--- ec2/dta.tf

data "aws_ami" "this" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240801"]
  }
}
