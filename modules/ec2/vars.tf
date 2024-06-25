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
variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of instances to create"
  type        = number
  default     = 1
}

variable "instance_ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

variable "instance_prefix" {
  description = "The prefix to use for the instance name"
  type        = string
  default     = "main"
}

variable "instance_sg_ingress" {
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

variable "instance_sg_egress" {
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
