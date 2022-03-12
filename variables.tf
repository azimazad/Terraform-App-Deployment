#Access Variables
variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {
  default = "us-east-1"
}



#VPC Variables
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_cidr_block" {
  default = "10.0.1.0/24"
}




#EC2 Variables
variable "instance_type" {
  default = "t2.micro"
}
variable "ami_id" {
  default = "ami-0e1d30f2c40c4c701"
}