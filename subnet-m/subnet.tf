resource "aws_subnet" "public-az1" {
    vpc_id = var.vpc_id
    cidr_block = var.public-cidr-az1
    map_public_ip_on_launch = true
    availability_zone = var.az-1
    tags = {
      "Name" = "public-subnet-az1" 
    }
}

resource "aws_subnet" "public-az2" {
    vpc_id = var.vpc_id
    cidr_block = var.public-cidr-az2
    map_public_ip_on_launch = true
    availability_zone = var.az-2
    tags = {
      "Name" = "public-subnet-az2" 
    }
}

resource "aws_subnet" "private-az1" {
    vpc_id = var.vpc_id
    cidr_block = var.private-cidr-az1
    availability_zone = var.az-1
    tags = {
      "Name" = "private-subnet-az1" 
    }
}

resource "aws_subnet" "private-az2" {
    vpc_id = var.vpc_id
    cidr_block = var.private-cidr-az2
    availability_zone = var.az-2
    tags = {
      "Name" = "private-subnet-az2" 
    }
}

