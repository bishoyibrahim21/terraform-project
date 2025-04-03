resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet-gateway-id
  }
  tags = {
    "Name" = "bishoy-internet-route"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = var.public_subnet_az1-id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = var.public_subnet_az2-id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat-gateway-id
  }
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = var.private_subnet_az1-id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = var.private_subnet_az2-id
  route_table_id = aws_route_table.private_rt.id
}