variable "name" {
  type        = string
  # default     = "jelee"
}

variable "region" {
  type        = string
  # default     = "ap-northeast-2"
}

variable "ava" {
  type        = list(string)
  #default     = ["a", "c"]
}

variable "key" {
  type        = string
#  default     = "jelee2-key"
}

variable "key_file" {
  type        = string
#  default     = "../../.ssh/jelee-key.pub"
}

variable "cidr_main" {
  type        = string
#  default     = "10.0.0.0/16"
}

variable "cidr_public" {
  type        = list(string)
#  default     = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "cidr_private" {
  type        = list(string)
#  default     = [ "10.0.1.0/24", "10.0.3.0/24" ] 
}

variable "cidr_privatedb" {
  type        = list(string)
 # default     = [ "10.0.5.0/24", "10.0.6.0/24" ] 
}

variable "cidr_route" {
   type       = string
  # default = "0.0.0.0/0" 
}

variable "cidr_route_6" {
   type       = string
   #default = "::/0" 
}

variable "port_http"{
  type        = number
 # default     = 80
}

variable "port_ssh"{
  type        = number
  #default     = 2
}

variable "port_mysql"{
  type        = number
 # default     = 3306
}

variable "port_icmp"{
  type        = number
 # default     = 0
}

variable "protocol_http"{
  type        = string
#  default     = "HTTP"
}

variable "protocol_tcp"{
  type        = string
 # default     = "TCP"
}

variable "protocol_icmp"{
  type        = string
  #default     = "icmp"
}

variable "ec2_ami"{
  type        = string
#  default     = "ami-04e8dfc09b22389ad"
}

variable "ip_private" {
  type       = string
 # default = "10.0.0.11" 
}

variable "instance_type" {
  type       = string
 # default    = "t2.micro"
}

variable "user_data_file" {
  type       = string
#  default    = "./install.sh"
}

variable "load_type" {
  type       = string
 # default     = "application"
}

variable "storage_size" {
  type       = number
  #default     = 20
}

variable "storage_type" {
  type       = string
  #default     = "gp2"
}

variable "storage_engine" {
  type       = string
  #default    = "mysql"
}

variable "storage_engine_ver" {
  type       = string
  #default    = "8.0"
}

variable "db_instance" {
  type       = string
#  default    = "db.t2.micro"
}

 variable "db_name" {
   type       = string
 #  default    = "test"
 }

 variable "db_username" {
   type       = string
  # default    = "admin"
 }

 variable "db_password" {
   type       = string
   #default    = "It12345!"
 }