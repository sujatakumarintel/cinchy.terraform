variable "clustername" {
  type    = string
}

variable "vpnsecuritygroup" {
  type    = string
}

variable "subnet" {
  type    = list(string)
}

variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

# variable "access_key" {
#   type = string
# }

# variable "secret_key" {
#   type = string
# }

variable "usermapping" {
  type = string
}

variable "instancetype" {
  type = string
}

variable "disk_size" {
  type = string
}
