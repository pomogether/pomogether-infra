variable "name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "task_arn" {
  description = "The ARN of the task definition"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task to run"
  type        = number
}

variable "launch_type" {
  description = "The launch type on which to run the service"
  type        = string
}

variable "network_configuration" {
  description = "The network configuration for the service"
  type = object({
    subnets          = list(string)
    security_groups  = list(string)
    assign_public_ip = bool
  })

  default = {
    subnets          = []
    security_groups  = []
    assign_public_ip = false
  }
}
