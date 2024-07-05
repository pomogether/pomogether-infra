variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# # # Subnet # # #
variable "subnet_config" {
  description = "The CIDR blocks to be used for the subnet(s)"
  type = list(object({
    cidr_block  = string
    az          = string
    route_table = string
  }))
}

variable "subnet_name" {
  description = "The name to use for the subnet"
  type        = string
  default     = "main"
}
