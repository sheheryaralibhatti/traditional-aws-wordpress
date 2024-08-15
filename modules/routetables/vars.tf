variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets_id" {
  type = list(string)
}

variable "private_subnets_id" {
  type = list(string)
}
