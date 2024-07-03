resource "aws_ecs_service" "main" {
  name            = var.name
  cluster         = var.cluster_id
  task_definition = var.task_arn
  desired_count   = var.desired_count

  launch_type = var.launch_type

  network_configuration {
    subnets          = var.network_configuration.subnets
    security_groups  = var.network_configuration.security_groups
    assign_public_ip = var.network_configuration.assign_public_ip
  }
}
