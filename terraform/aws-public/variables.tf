variable "region" {
  type = string
}

variable "env_name" {
  type = string
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ubuntu_version" {
  type    = string
  default = "focal-20.04-amd64-server"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "volume_size" {
  type    = number
  default = 86
}

variable "destroy" {
  type    = bool
  default = false
}

variable "ubuntu" {
  type    = bool
  default = true
}

variable "centos" {
  type    = bool
  default = true
}

variable "redhat" {
  type    = bool
  default = true
}
