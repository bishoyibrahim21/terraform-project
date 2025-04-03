output "public-target-group-arn" {
  value = aws_lb_target_group.public_tg.arn
}
output "private-target-group-arn" {
  value = aws_lb_target_group.private_tg.arn
}
output "public-elp-dns" {
  value = aws_lb.public_alb.dns_name
}
output "private-elp-dns" {
  value = aws_lb.private_alb.dns_name
}

