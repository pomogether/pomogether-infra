variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "igw_name" {
  description = "The name to use for the internet gateway"
  type        = string
  default     = "main"
}
