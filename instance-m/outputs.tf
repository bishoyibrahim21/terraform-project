output "public_instance_1_public_ip" {
  value = aws_instance.public-ec2-az1.public_ip
}

output "public_instance_2_public_ip" {
  value = aws_instance.public-ec2-az2.public_ip
}

output "private_instance_1_private_ip" {
  value = aws_instance.private-ec2-az1.private_ip
}

output "private_instance_2_private_ip" {
  value = aws_instance.private-ec2-az2.private_ip
}