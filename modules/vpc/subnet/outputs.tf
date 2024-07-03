output "subnet_ids" {
  description = "The IDs of the subnets"
  value = {
    for idx, subnet in aws_subnet.main : idx => subnet.id
  }
}
