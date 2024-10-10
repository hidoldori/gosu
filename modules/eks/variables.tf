#-- variables.tf


variable "subnett_ids" {
  description = "A list of CIDR blocks to use for the public subnets."
  type        = list(string)

  #-- multi az 이 필요함.
  //default     = ["subnet-0fedd10ecf55bbcc2","subnet-09d3d345818797715"]
}
