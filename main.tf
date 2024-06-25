module "ec2" {
  source          = "./modules/ec2"
  region          = "us-east-1"
  profile         = "vianaz"
  vpc_name        = "VPC Padrão"
  ami             = "ami-04b70fa74e45c3917"
  ssh_public_key  = "~/.ssh/id_rsa.pub"
  instance_prefix = "pomogether"
  instance_count  = 3
}
