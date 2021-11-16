module "stage" {
  source = "../01_test/"

  name = "jelee"
  region = "ap-northeast-2"
  ava = ["a", "c"]
  key = "jelee2-key"
  key_file = "../../.ssh/jelee-key.pub"
  cidr_main = "10.0.0.0/16"
  cidr_public = ["10.0.0.0/24", "10.0.2.0/24"]
  cidr_private = [ "10.0.1.0/24", "10.0.3.0/24" ] 
  cidr_privatedb = [ "10.0.5.0/24", "10.0.6.0/24" ] 
  cidr_route = "0.0.0.0/0"
  cidr_route_6 = "::/0"
  port_http = 80
  port_ssh = 22
  port_mysql = 3306
  port_icmp = 0
  protocol_http = "HTTP"
  protocol_tcp = "TCP"
  protocol_icmp = "icmp"
  ec2_ami = "ami-04e8dfc09b22389ad"
  ip_private = "10.0.0.11" 
  instance_type = "t2.micro"
  user_data_file = "../install.sh"
  load_type = "application"
  storage_size = 20
  storage_type = "gp2"
  storage_engine = "mysql"
  storage_engine_ver = "8.0"
  db_instance = "db.t2.micro"
  db_name = "test"
  db_username = "admin"
  db_password = "It12345!"
}