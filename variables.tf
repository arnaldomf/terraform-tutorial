variable "region" {
  default = "us-east-1"
}

variable "ami" {
  description = "AMI name for instance"
  default = "ami-b374d5a5"
}

variable "profile" {
  default = "personal"
}

variable "vpc_id" {
  default = "vpc-7418c011"
}

variable "server_port" {
  default = 8080
}
