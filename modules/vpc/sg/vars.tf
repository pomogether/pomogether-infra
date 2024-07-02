variable "vpc_id" {
  description = "The ID of the VPC to use"
  type        = string
}

# # # Security Group # # #
variable "name" {
  description = "The prefix to use for the security group name"
  type        = string
}

variable "ingress" {
  description = "The inbound rules of security group to use for the instance"
  type = set(object({
    from_port        = number
    to_port          = number
    cidr_blocks      = list(string)
    description      = optional(string)
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
    protocol         = string
    security_groups  = optional(list(string))
    self             = optional(bool)
  }))
}
