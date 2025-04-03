module "s3-StateFile" {
  source = "./s3-statefile"
}

terraform {
  backend "s3" {
    bucket         = "bishoy-remote-statefile"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

module "vpc" {
  source = "./vpc-m"
  vpc-cidr = "10.0.0.0/16"
}

module "subnets" {
  source = "./subnet-m"
  vpc_id = module.vpc.VPC-id

  public-cidr-az1 = "10.0.1.0/24"
  public-cidr-az2 = "10.0.2.0/24"
  private-cidr-az1 = "10.0.3.0/24"
  private-cidr-az2 = "10.0.4.0/24"

  az-1 = "us-east-1a"
  az-2 = "us-east-1b"
}

module "gateways" {
  source = "./gateways-m"
  vpc-id = module.vpc.VPC-id

  public_subnet_az1-id = module.subnets.public-subnet-az1-id
}

module "routes" {
  source = "./routes-m"
  vpc-id = module.vpc.VPC-id

  internet-gateway-id = module.gateways.internet-gateway-id
  nat-gateway-id = module.gateways.nat-gateway-az1-id

  public_subnet_az1-id = module.subnets.public-subnet-az1-id
  public_subnet_az2-id = module.subnets.public-subnet-az2-id

  private_subnet_az1-id = module.subnets.private-subnet-az1-id
  private_subnet_az2-id = module.subnets.private-subnet-az2-id
}

module "sg" {
  source = "./SecurityGroups-m"
  vpc-id = module.vpc.VPC-id
}

module "elbs" {
  source = "./elb-m"
  vpc-id = module.vpc.VPC-id

  private-securitygroup-id = module.sg.private-sg-id
  public-securitygroup-id = module.sg.public-sg-id

  private-subnet-az1-id = module.subnets.private-subnet-az1-id
  private-subnet-az2-id = module.subnets.private-subnet-az2-id

  public-subnet-az1-id = module.subnets.public-subnet-az1-id
  public-subnet-az2-id = module.subnets.public-subnet-az2-id
}

module "instances" {
  source = "./instance-m"
  public-subnet-az1-id = module.subnets.public-subnet-az1-id
  public-subnet-az2-id = module.subnets.public-subnet-az2-id

  private-subnet-az1-id = module.subnets.private-subnet-az1-id
  private-subnet-az2-id = module.subnets.private-subnet-az2-id

  public-securitygroup-id = module.sg.public-sg-id
  private-securitygroup-id = module.sg.private-sg-id

  public-targetgroup-arn = module.elbs.public-target-group-arn
  private-targetgroup-arn = module.elbs.private-target-group-arn
}

