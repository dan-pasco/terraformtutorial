provider "aws" {
  region = "ap-southeast-2"
}


variable "ingressvar" {

  type = list(number)
  default = [ 80,443,22 ]
  
}


variable "egressvar" {

  type = list(number)
  default = [ 80,443,22 ]
  
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c635ee4f691a2310"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.EC2_SG.name]
  
  
  tags = {
    Name = "MyExam"
}
}

output "Instance_public_IP" {
    value = aws_instance.my_instance.public_ip
}

resource "aws_eip" "lb" {
  instance = aws_instance.my_instance.id
}

resource "aws_security_group" "EC2_SG" {

  name = "Allow Traffic"

  dynamic "ingress"{
    iterator = port
    for_each = var.ingressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  dynamic "egress"{
    iterator = port
    for_each = var.egressvar
    content{
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  
  tags = {

    Name = "Allow Tls"

  }
}