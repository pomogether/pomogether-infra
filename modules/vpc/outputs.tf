output "id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}
