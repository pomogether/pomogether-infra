resource "aws_security_group" "main" {
  name   = var.name
  vpc_id = var.vpc_id

  ingress = var.ingress

  tags = {
    Name = var.name
  }
}
