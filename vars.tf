variable "region" {
  description = "The AWS region things are created in"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "The AWS profile to be used"
  type        = string
  default     = "vianaz"
}

variable "vpc_cidr_block" {
  description = "The VPC configuration"
  type        = string
}

variable "route_table_config" {
  description = "The route table configuration"
  type = object({
    public = object({
      name       = string
      cidr_block = string
    })
    routes = list(object({
      name = string
    }))
  })
}

variable "subnet_config" {
  description = "The subnet configuration"
  type = list(object({
    cidr_block  = string
    az          = string
    route_table = string
  }))
}

variable "sg_config" {
  description = "The security group configuration"
  type = object({
    name = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  })

  default = {
    name    = ""
    ingress = []
    egress  = []
  }
}
