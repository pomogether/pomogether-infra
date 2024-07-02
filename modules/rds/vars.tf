# # # Security Group # # #
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
}

# # # Cluster # # #
variable "cluster_name" {
  description = "The name to use for the cluster"
  type        = string
}
variable "cluster_engine" {
  description = "The engine to use for the cluster"
  type        = string
  default     = "aurora-postgresql"

  validation {
    condition     = var.cluster_engine == "aurora-postgresql"
    error_message = "The engine must be either 'aurora-postgresql'"
  }
}
variable "cluster_engine_version" {
  description = "The engine version to use for the cluster"
  type        = string
  default     = "15.4"
}
variable "cluster_availability_zones" {
  description = "The availability zones to use for the cluster"
  type        = list(string)
}
variable "cluster_db_name" {
  description = "The name of the database to use for the cluster"
  type        = string
}
variable "cluster_db_username" {
  description = "The username to use for the database"
  type        = string
  default     = "foo"
}
variable "cluster_db_password" {
  description = "The password to use for the database"
  type        = string
}
variable "cluster_subnets_id" {
  description = "The subnets to use for the cluster"
  type        = list(string)
}

# # # Cluster Instances # # #
variable "cluster_instance_class" {
  description = "The instance class to use for the cluster"
  type        = string
  default     = "db.t3.medium"
}

variable "cluster_instance_publicly_accessible" {
  description = "Whether the instances should be publicly accessible"
  type        = bool
  default     = false
}


