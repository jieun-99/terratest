module "stage" {
  source = "../01_test/"

  name = "jelee"
  region = "ap-northeast-3"
  ava = ["a", "c"]
  key = "jelee2-key"
  key_file = "../../.ssh/jelee-key.pub"
  cidr_main = "192.168.0.0/16"
  cidr_public = ["192.168.0.0/24", "192.168.2.0/24"]
  cidr_private = [ "192.168.1.0/24", "192.168.3.0/24" ] 
  cidr_privatedb = [ "192.168.5.0/24", "192.168.6.0/24" ] 
  cidr_route = "0.0.0.0/0"
  cidr_route_6 = "::/0"
  port_http = 80
  port_ssh = 22
  port_mysql = 3306
  port_icmp = 0
  protocol_http = "HTTP"
  protocol_tcp = "TCP"
  protocol_icmp = "icmp"
  ec2_ami = "ami-0d9649ef6deb663a7"
  ip_private = "192.168.0.11" 
  instance_type = "t3.small"
  user_data_file = "../install.sh"
  load_type = "application"
  storage_size = 20
  storage_type = "gp2"
  storage_engine = "mysql"
  storage_engine_ver = "8.0"
  db_instance = "db.t3.small"
  db_name = "test"
  db_username = "admin"
  db_password = "It12345!"
}