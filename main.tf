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
    }
  ]
}

module "sg" {
  source = "./modules/vpc/sg"

  name   = "pomogether-ecs-sg"
  vpc_id = module.vpc.id

  ingress = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "ecs_task" {
  source = "./modules/ecs/task"

  family                   = "pomogether"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512

  container_definitions = [
    {
      name      = "pomogether-nginx"
      image     = "nginx:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ]
}

module "ecs_cluster" {
  source = "./modules/ecs/cluster"

  name               = "pomogether"
  capacity_providers = ["FARGATE_SPOT"]
}

module "ecs_service" {
  depends_on = [module.ecs_cluster, module.ecs_task, module.subnet]
  source     = "./modules/ecs/service"

  name          = "pomogether"
  cluster_id    = module.ecs_cluster.id
  task_arn      = module.ecs_task.arn
  desired_count = 1

  launch_type = "FARGATE"

  network_configuration = {
    subnets          = [module.subnet.subnet_ids[0]]
    security_groups  = [module.sg.id]
    assign_public_ip = true
  }
}
