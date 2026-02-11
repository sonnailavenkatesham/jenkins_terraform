variable "ami_id" {
  default = "ami-0b6c6ebed2801a5cb"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "servers" {
  default = ["server1", "server2"]
}