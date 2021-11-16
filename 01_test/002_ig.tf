# 10.0.0.0/16 VPC 전용 Internet Gateway
resource "aws_internet_gateway" "jelee_ig"{
  vpc_id = aws_vpc.jelee_vpc.id

  tags ={
    "Name" = "${var.name}-ig"
  }
}

resource "aws_route_table" "jelee_rt" {
  vpc_id = aws_vpc.jelee_vpc.id
  
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.jelee_ig.id
  }

  tags = {
    "Name" = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "jelee_rtass" {
  count = length(var.cidr_public)
  subnet_id      = aws_subnet.jelee_pub[count.index].id
  route_table_id = aws_route_table.jelee_rt.id
}