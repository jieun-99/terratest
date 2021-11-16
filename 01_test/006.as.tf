resource "aws_ami_from_instance" "jelee_ami" {
  name               = "${var.name}-aws_ami"
  source_instance_id = aws_instance.jelee_web.id

  depends_on = [
    aws_instance.jelee_web
  ]

  tags ={
    "Name" = "${var.name}-aws-ami"
  }
}

resource "aws_launch_configuration" "jelee_aslc" {
  name          = "${var.name}-web-"
  image_id      = aws_ami_from_instance.jelee_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.jelee_sg.id]
  key_name = var.key
  user_data = file(var.user_data_file)

  # lifecycle {
  #   create_before_destroy = true
  # }

}

resource "aws_placement_group" "jelee_place" {
  name     = "${var.name}-place"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "jelee_asg" {
  name                      = "${var.name}-asg"
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 10
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.jelee_aslc.name
  vpc_zone_identifier       = [aws_subnet.jelee_pub[0].id, aws_subnet.jelee_pub[1].id]

}

resource "aws_autoscaling_attachment" "jelee_asgalbatt" {
  autoscaling_group_name = aws_autoscaling_group.jelee_asg.id
  alb_target_group_arn = aws_lb_target_group.jelee_albtg.arn
}
