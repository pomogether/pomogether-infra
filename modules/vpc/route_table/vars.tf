variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# # # Default Route Table # # #
variable "default_route_table_config" {
  description = "The configuration for the default route table"
  type = object({
    id         = string
    name       = string
    cidr_block = string
    gateway_id = string
  })
}

# # # Route Table # # #
variable "route_table_config" {
  description = "Name of the route table"
  type = list(object({
    name = string
  }))

  default = []
}
