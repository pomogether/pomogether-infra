resource "aws_security_group" "main" {
  name   = "${var.instance_prefix}-sg"
  vpc_id = data.aws_vpc.main.id

  ingress = var.instance_sg_ingress
  egress = var.instance_sg_egress
  
  tags = {
    Name = "${var.instance_prefix}-sg"
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.instance_prefix}-ssh-key"
  public_key = file(var.ssh_public_key)
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.instance_count
  
  subnet_id       = data.aws_subnet.main.id
  security_groups = [aws_security_group.main.id]

  key_name = aws_key_pair.main.key_name

  tags = {
    Name = "${var.instance_prefix}-${count.index}"
  }
}
