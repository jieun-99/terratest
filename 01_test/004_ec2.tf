resource "aws_security_group" "jelee_sg" {
  name        = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id      = aws_vpc.jelee_vpc.id

  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route_6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
    ,
    {
      description      = "Allow SSH"
      from_port        = var.port_ssh
      to_port          = var.port_ssh
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route_6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
    ,
    {
      description      = "Allow MySQL"
      from_port        = var.port_mysql
      to_port          = var.port_mysql
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route_6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
    ,
    {
      description      = "Allow ICMP"
      from_port        = var.port_icmp
      to_port          = var.port_icmp
      protocol         = var.protocol_icmp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route_6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }

  ]

  egress = [
    {
      description      = "ALL"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route_6]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_instance" "jelee_web" {
  ami                    = var.ec2_ami               #"ami-0e4a9ad2eb120e054"
  instance_type          = var.instance_type
  key_name               = var.key
  availability_zone      = "${var.region}${var.ava[0]}"
  private_ip             = var.ip_private
  subnet_id              = aws_subnet.jelee_pub[0].id   #public_subnet a의 ID
  security_groups        = [aws_security_group.jelee_sg.id]
  user_data              = file(var.user_data_file)
  tags = {
    Name = "${var.name}-web${var.ava[0]}"
  }
}

resource "aws_eip" "jelee_web_eip" {
  vpc = true
  instance                    = aws_instance.jelee_web.id
  associate_with_private_ip   = var.ip_private
  depends_on                  = [aws_internet_gateway.jelee_ig]
}

output "public_ip" {
  value = aws_instance.jelee_web.public_ip
}
