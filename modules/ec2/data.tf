data "aws_vpc" "main" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnet" "main" {
  vpc_id = data.aws_vpc.main.id
}