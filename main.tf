module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"
}

module "internet_gateway" {
  depends_on = [module.vpc]
  source     = "./modules/vpc/internet_gateway"

  vpc_id = module.vpc.id
}

module "route_table" {
  depends_on = [module.vpc]
  source     = "./modules/vpc/route_table"

  vpc_id = module.vpc.id

  default_route_table_config = {
    id   = module.vpc.default_route_table_id
    name = "main-public"

    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.id
  }

  route_table_config = [
    {
      name = "main-private-us-east-1a"
    },
    {
      name = "main-private-us-east-1b"
    }
  ]
}

module "subnet" {
  depends_on = [module.route_table, module.vpc]
  source     = "./modules/vpc/subnet"

  vpc_id = module.vpc.id
  subnet_config = [
    {
      cidr_block     = "10.0.0.0/24"
      az             = "us-east-1a"
      route_table_id = module.route_table.default_route_table_id
    },
    {
      cidr_block     = "10.0.1.0/24"
      az             = "us-east-1a"
      route_table_id = module.route_table.route_table_ids[0]
    },
    {
      cidr_block     = "10.0.2.0/24"
      az             = "us-east-1b"
      route_table_id = module.route_table.route_table_ids[1]
    }
  ]
}

module "ec2" {
  source     = "./modules/ec2"
  depends_on = [module.subnet]
  for_each = {
    public_instance = {
      subnet_id = module.subnet.subnet_ids[0]
      public_ip = true
    }
    private_instance = {
      subnet_id = module.subnet.subnet_ids[1]
      public_ip = false
    }
  }

  name           = "pomogether-${each.value.subnet_id}"
  ami            = "ami-04b70fa74e45c3917"
  ssh_public_key = "~/.ssh/id_rsa.pub"

  vpc_id    = module.vpc.id
  subnet_id = each.value.subnet_id
  public_ip = each.value.public_ip
}

module "rds" {
  source     = "./modules/rds"
  depends_on = [module.subnet]

  cluster_name               = "pomogether"
  cluster_db_name            = "pomogether"
  cluster_db_username        = "pomogether"
  cluster_db_password        = "pomogether197320"
  cluster_availability_zones = ["us-east-1a", "us-east-1b"]
  cluster_subnets_id         = [module.subnet.subnet_ids[1], module.subnet.subnet_ids[2]]

  sg_ingress = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
