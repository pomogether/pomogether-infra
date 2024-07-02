# # # VPC # # #
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to use for the instance"
  type        = string
}

# # # AMI # # #
variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

# # # SSH Key # # #
variable "ssh_public_key" {
  description = "The SSH public key path to be use sended for the instance"
  type        = string
}

# # # Instance # # #
variable "type" {
  description = "The instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "name" {
  description = "The prefix to use for the instance name"
  type        = string
  default     = "main"
}

variable "public_ip" {
  description = "Whether the instance should have a public IP address"
  type        = bool
  default     = false
}

variable "sg_ingress" {
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

  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_egress" {
  description = "The outbound rules of security group to use for the instance"
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

  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
