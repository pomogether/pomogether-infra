variable "family" {
  description = "The family name for the ECS task definition"
  type        = string
}

variable "network_mode" {
  description = "The network mode to use for the ECS task definition"
  type        = string
}

variable "requires_compatibilities" {
  description = "The compatibilities required for the ECS task definition"
  type        = list(string)
}

variable "cpu" {
  description = "The amount of CPU to reserve for the ECS task"
  type        = number
}

variable "memory" {
  description = "The amount of memory to reserve for the ECS task"
  type        = number
}

variable "container_definitions" {
  description = "The container definitions for the ECS task"
  type = list(object({
    name      = string
    image     = string
    cpu       = number
    memory    = number
    essential = bool
    portMappings = list(object({
      containerPort = number
      hostPort      = number
    }))
  }))
}
