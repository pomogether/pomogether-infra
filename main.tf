module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
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

  public_route_table_config = {
    id         = module.vpc.default_route_table_id
    gateway_id = module.internet_gateway.id

    name       = var.route_table_config["public"]["name"]
    cidr_block = var.route_table_config["public"]["cidr_block"]
  }

  route_table_config = var.route_table_config["routes"]
}

module "subnet" {
  depends_on = [module.route_table, module.vpc]
  source     = "./modules/vpc/subnet"

  vpc_id = module.vpc.id

  subnet_config = [
    for idx, subnet in var.subnet_config : {
      cidr_block  = subnet["cidr_block"]
      az          = subnet["az"]
      route_table = subnet["route_table"]
    }
  ]
}

# module "sg" {
#   source = "./modules/vpc/sg"

#   vpc_id = module.vpc.id

#   name    = var.vpc_config["sg_config"]["name"]
#   ingress = var.vpc_config["sg_config"]["ingress"]
#   egress  = var.vpc_config["sg_config"]["egress"]
# }

# module "ecs_task" {
#   source = "./modules/ecs/task"

#   family                   = "pomogether"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]

#   cpu    = 256
#   memory = 512

#   container_definitions = [
#     {
#       name      = "pomogether-nginx"
#       image     = "nginx:latest"
#       cpu       = 256
#       memory    = 512
#       essential = true
#       portMappings = [{
#         containerPort = 80
#         hostPort      = 80
#       }]
#     }
#   ]
# }

# module "ecs_cluster" {
#   source = "./modules/ecs/cluster"

#   name               = "pomogether"
#   capacity_providers = ["FARGATE_SPOT"]
# }

# module "ecs_service" {
#   depends_on = [module.ecs_cluster, module.ecs_task, module.subnet]
#   source     = "./modules/ecs/service"

#   name          = "pomogether"
#   cluster_id    = module.ecs_cluster.id
#   task_arn      = module.ecs_task.arn
#   desired_count = 1

#   launch_type = "FARGATE"

#   network_configuration = {
#     subnets          = [module.subnet.subnet_ids[0]]
#     security_groups  = [module.sg.id]
#     assign_public_ip = true
#   }
# }
