data "aws_vpc" "main" {
  tags = {
    Name = "VPC Padrão"
  }
}

data "aws_subnet" "main" {
  vpc_id = data.aws_vpc.main.id
}

module "ec2" {
  source          = "./modules/ec2"
  region          = "us-east-1"
  profile         = "vianaz"
  vpc_id          = data.aws_vpc.main.id
  ami             = "ami-04b70fa74e45c3917"
  ssh_public_key  = "~/.ssh/id_rsa.pub"
  instance_prefix = "pomogether"
  instance_count  = 3
  subnet_id       = data.aws_subnet.main.id
}
