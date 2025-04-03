variable "vpc-id" {
    description = "the id of the vpc"
}

variable "public_subnet_az1-id" {
    description = "the id of the public subnet in az1"
}

variable "public_subnet_az2-id" {
    description = "the id of the public subnet in az2"
}

variable "private_subnet_az1-id" {
    description = "the id of the private subnet in az1"
}

variable "private_subnet_az2-id" {
    description = "the id of the private subnet in az2"
}

variable "internet-gateway-id" {
  description = "the id of the internet gateway for the public subnets"
}

variable "nat-gateway-id" {
    description = "the id of the nat gateway for the private subnets" 
}