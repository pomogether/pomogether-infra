resource "aws_default_route_table" "main" {
  default_route_table_id = var.public_route_table_config.id

  route {
    cidr_block = var.public_route_table_config.cidr_block
    gateway_id = var.public_route_table_config.gateway_id
  }

  tags = {
    Name = var.public_route_table_config.name
  }
}

resource "aws_route_table" "main" {
  for_each = {
    for idx, route_table in var.route_table_config : idx => route_table
  }

  vpc_id = var.vpc_id

  tags = {
    "Name" = each.value.name
  }
}
