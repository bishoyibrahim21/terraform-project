output "internet-gateway-id" {
    value = aws_internet_gateway.igw.id
}
output "nat-gateway-az1-id" {
  value = aws_nat_gateway.nat_gw.id
}
