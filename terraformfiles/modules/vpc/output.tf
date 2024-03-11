output "vpc-id" {
  value = aws_vpc.main.id
}
output "private-subnets" {
    value = aws_subnet.private-subnet.*.id
}
output "public-subnet-id" {
  value = aws_subnet.public-subnet[0].id
}
output "public-subnets" {
  value = aws_subnet.public-subnet.*.id
}