output "subnet_ids" {
  value = {
    for idx, subnet in aws_subnet.main : idx => subnet.id
  }
}
