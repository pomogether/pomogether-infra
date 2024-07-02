output "default_route_table_id" {
  value = aws_default_route_table.main.id
}

output "route_table_ids" {
  value = {
    for idx, route_table in aws_route_table.main : idx => route_table.id
  }
}
