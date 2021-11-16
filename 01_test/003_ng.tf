resource "aws_eip" "jelee_eip_ng" {
  vpc      = true
}

resource "aws_nat_gateway" "jelee_ng" {
  allocation_id = aws_eip.jelee_eip_ng.id
  subnet_id     = aws_subnet.jelee_pub[0].id

  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [aws_internet_gateway.jelee_ig]
}

resource "aws_route_table" "jelee_ngrt" {
  vpc_id = aws_vpc.jelee_vpc.id
  
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.jelee_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "jelee_ngass" {
  count = length(var.cidr_private)
  subnet_id      = aws_subnet.jelee_pri[count.index].id
  route_table_id = aws_route_table.jelee_ngrt.id
}