resource "aws_lb" "jelee_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = var.load_type
  security_groups    = [aws_security_group.jelee_sg.id]
  subnets            = [aws_subnet.jelee_pub[0].id, aws_subnet.jelee_pub[1].id]

  tags = {
    "Name" = "${var.name}-alb"
  }
}

output "alb_dns"{
  value = aws_lb.jelee_alb.dns_name
}

resource "aws_lb_target_group" "jelee_albtg" {
  name        = "${var.name}-albtg"
  port        = var.port_http
  protocol    = var.protocol_http
  target_type = "instance"
  vpc_id      = aws_vpc.jelee_vpc.id


  health_check {
    enabled             = true
    healthy_threshold    = 3
    interval            = 5
    matcher             = "200"
    path                = "/index.html"
    port                = "traffic-port"
    protocol            = var.protocol_http
    timeout             = 2
    unhealthy_threshold = 2

  }
}

resource "aws_lb_listener" "jelee_albli" {
  load_balancer_arn = aws_lb.jelee_alb.arn
  port              = var.port_http
  protocol          = var.protocol_http

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jelee_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "jelee_tgatt" {
  target_group_arn = aws_lb_target_group.jelee_albtg.arn
  target_id        = aws_instance.jelee_web.id
  port             = var.port_http
}