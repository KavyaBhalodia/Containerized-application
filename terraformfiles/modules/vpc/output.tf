output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_nacl" {
  value = aws_vpc.main.default_network_acl_id
}
output "private_subnets" {
    value = aws_subnet.private_subnet.*.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet[0].id
}
output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}