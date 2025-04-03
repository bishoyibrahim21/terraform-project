resource "aws_vpc" "vpc-1" {
    cidr_block = var.vpc-cidr
    tags = {
      "Name" = "vpc-bishoy" 
    }
  
}