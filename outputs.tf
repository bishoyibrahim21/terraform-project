output "public-elp-dns" {
  value = module.elbs.public-elp-dns
}
output "private-elp-dns" {
  value = module.elbs.private-elp-dns
}
output "public_instance_1_public_ip" {
  value = module.instances.public_instance_1_public_ip
}
output "public_instance_2_public_ip" {
  value = module.instances.public_instance_2_public_ip
}
output "private_instance_1_private_ip" {
  value = module.instances.private_instance_1_private_ip
}
output "private_instance_2_private_ip" {
  value = module.instances.private_instance_2_private_ip
}