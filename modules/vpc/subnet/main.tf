resource "aws_subnet" "main" {
  for_each = {
    for idx, subnet in var.subnet_config : idx => subnet
  }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    "Name" = "${var.subnet_name}-${each.key}-${each.value.az}"
  }
}

resource "aws_route_table_association" "main" {
  for_each = {
    for idx, subnet in var.subnet_config : idx => subnet
  }

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = each.value.route_table_id
}
