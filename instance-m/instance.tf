data "aws_ami" "linux-ami" {
  most_recent = true
  filter {
    name = "name"
    values = [ "al2023-ami-2023.*" ]
  }
}

resource "aws_instance" "public-ec2-az1" {
    ami = data.aws_ami.linux-ami.id
    instance_type = "t2.micro"
    subnet_id = var.public-subnet-az1-id
    vpc_security_group_ids = [ var.public-securitygroup-id ]
    key_name = "terraform-project"
    provisioner "local-exec" {
      command = "echo ec2 az1 public ip = ${self.public_ip}"
    }
    provisioner "remote-exec" {
      inline = [ 
        "sudo yum update -y",
        "sudo yum install httpd -y",
        "sudo echo az1 > /var/www/html/index.html",
        "sudo systemctl enable --now httpd"
       ]
       connection {
         type = "ssh"
         user = "ec2-user"
         private_key = file("./terraform-project.pem")
         host = self.public_ip
       }
    }
    tags = {
      "Name" = "public-ec2-az1"
    }
}

resource "aws_instance" "public-ec2-az2" {
    ami = data.aws_ami.linux-ami.id
    instance_type = "t2.micro"
    subnet_id = var.public-subnet-az2-id
    vpc_security_group_ids = [ var.public-securitygroup-id ]
    key_name = "terraform-project"
    provisioner "local-exec" {
      command = "echo ec2 az2 public ip = ${self.public_ip}"
    }
    provisioner "remote-exec" {
      inline = [ 
        "sudo yum update -y",
        "sudo yum install httpd -y",
        "sudo echo az2 > /var/www/html/index.html",
        "sudo systemctl enable --now httpd"
       ]
       connection {
         type = "ssh"
         user = "ec2-user"
         private_key = file("./terraform-project.pem")
         host = self.public_ip
       }
    }
    tags = {
      "Name" = "public-ec2-az2"
    }
}

resource "aws_lb_target_group_attachment" "public_instance_1" {
  target_group_arn = var.public-targetgroup-arn
  target_id        = aws_instance.public-ec2-az1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "public_instance_2" {
  target_group_arn = var.public-targetgroup-arn
  target_id        = aws_instance.public-ec2-az2.id
  port             = 80
}

resource "aws_instance" "private-ec2-az1" {
    ami = data.aws_ami.linux-ami.id
    instance_type = "t2.micro"
    subnet_id = var.private-subnet-az1-id
    vpc_security_group_ids = [ var.private-securitygroup-id ]
    user_data = <<-EOF
                   #!/bin/bash
                   sudo yum update -y
                   sudo yum install httpd -y
                   sudo echo 'private ec2 in az1' > /var/www/html/index.html 
                   sudo systemctl enable --now httpd
                   EOF
    tags = {
      "Name" = "private-ec2-az1"
    }
}

resource "aws_instance" "private-ec2-az2" {
    ami = data.aws_ami.linux-ami.id
    instance_type = "t2.micro"
    subnet_id = var.private-subnet-az2-id
    vpc_security_group_ids = [ var.private-securitygroup-id ]
    user_data = <<-EOF
                   #!/bin/bash
                   sudo yum update -y
                   sudo yum install httpd -y
                   sudo echo 'private ec2 in az2' > /var/www/html/index.html 
                   sudo systemctl enable --now httpd
                   EOF
    tags = {
      "Name" = "private-ec2-az2"
    }
}

resource "aws_lb_target_group_attachment" "private_instance_1" {
  target_group_arn = var.private-targetgroup-arn
  target_id        = aws_instance.private-ec2-az1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_instance_2" {
  target_group_arn = var.private-targetgroup-arn
  target_id        = aws_instance.private-ec2-az2.id
  port             = 80
}