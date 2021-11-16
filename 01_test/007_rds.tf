resource "aws_db_instance" "jelee_rds" {
  allocated_storage = var.storage_size #20
  storage_type = var.storage_type #"gp2"
  engine = var.storage_engine #"mysql"
  engine_version = var.storage_engine_ver #"8.0"
  instance_class = var.db_instance #"db.t2.micro"
  name = var.db_name
  identifier = var.db_name
  username = var.db_username
  password = var.db_password
  parameter_group_name = "default.mysql8.0"
  availability_zone = "${var.region}${var.ava[0]}"
  db_subnet_group_name = aws_db_subnet_group.jelee_dbsb.id
  vpc_security_group_ids = [aws_security_group.jelee_sg.id]
  skip_final_snapshot = true
  tags = {
    "Name" = "${var.name}-rds"
  }
}

resource "aws_db_subnet_group" "jelee_dbsb" {
  name = "${var.name}-dbsb-group"
  subnet_ids = [aws_subnet.jelee_pridb[0].id, aws_subnet.jelee_pridb[1].id]
  tags = {
    "Name" = "${var.name}-dbsb-gp"
  }
}
