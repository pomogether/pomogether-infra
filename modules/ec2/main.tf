resource "aws_security_group" "main" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id

  ingress = var.sg_ingress
  egress  = var.sg_egress

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.name}-ssh-key"
  public_key = file(var.ssh_public_key)
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.type

  associate_public_ip_address = var.public_ip
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.main.id]

  key_name = aws_key_pair.main.key_name

  tags = {
    Name = var.name
  }
}
