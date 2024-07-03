variable "name" {
  description = "The name to use in ECS Cluster"
  type        = string
}

variable "capacity_providers" {
  description = "The providers to use in ECS Cluster"
  type        = list(string)
}
