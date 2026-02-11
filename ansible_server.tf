resource "aws_instance" "server" {
  count = length(var.instance_type)
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = "terrafrom"
  security_groups = [aws_security_group.allow_server.name]
  tags = {
    Name      = var.servers[count.index]
    Terraform = "Yes"
  }
}