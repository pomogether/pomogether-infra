output "arn" {
  description = "The ARN of the task definition"
  value       = aws_ecs_task_definition.main.arn
}
