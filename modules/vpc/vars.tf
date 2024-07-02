# # # VPC # # #
variable "vpc_name" {
  description = "The name to use for the VPC"
  type        = string
  default     = "main"
}
variable "vpc_cidr_block" {
  description = "The CIDR block to use for the VPC"
  type        = string
}
