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

data "aws_route_tables" "main" {
  for_each = {
    for idx, subnet in var.subnet_config : idx => subnet
  }

  vpc_id = var.vpc_id

  filter {
    name   = "tag:Name"
    values = [each.value.route_table]
  }
}

resource "aws_route_table_association" "main" {
  for_each = {
    for idx, subnet in var.subnet_config : idx => subnet
  }

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = data.aws_route_tables.main[each.key].ids[0]
}
