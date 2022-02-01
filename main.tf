provider "aws" {
  region = "ap-southeast-2"
}



resource "aws_instance" "my_instance" {
  ami           = "ami-0c635ee4f691a2310"
  instance_type = "t2.micro"

  tags = {
    Name = "MyExam"
  
}
}

output "Instance Private IP" {
    value = aws_instance.my_instance.public_ip
}

resource "aws_eip" "lb" {
  instance = aws_instance.my_instance.id
}

resource "aws_security_groups" "EC2_SG" {
  
}