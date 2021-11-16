provider "aws" {
    region = var.region
}

resource "aws_key_pair" "jelee_key" {
  key_name = var.key
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAsJloMV9jarr/sy85jbDWUljPcGLIdQF7tuB9J3d/spiIE2ub0axdw6K2BwnWaSAhL+Tk143u0OEd430ZhNuv7GW67nKGZLMCVZGo25oDLSGDKZbRpNYo9rMdgV3zbk7GSXi2s7qNmIa0W+02Wp5vRdpYd7tb1jJwHoErNEEU/EUMRDpL0bSJFRknmEg3GTFml9mA81ldddC2EfCo53SysqvHYhhp1qF0SUdaz0TqIyfBUC08tXCvxXHYnLQ5x1UsM/ykwV5XEAQyFpNgROS14f3fMgtI8/IFTIeK6dqq6EoI9y8BlHavvP4Ob4i5qOFzoVAs3WuOPmWCbUMEKhaiZZyRo8iWrqttfRrnWbPJeoBLNk80wfzQEmTxfsbe6f13947nrAWMFxZTpWal5hPt8zUtz4/S0j/E8xQvUSyG+I7py5QpSN8X4WYgujh5uoM5roe0VulOPLNOJmIq+PJqnW/vmPKJcvld0xC0LfzFs8OP2GYE+FHGoq4vVrYPqhs="
  public_key = file(var.key_file)
}

resource "aws_vpc" "jelee_vpc" {
  cidr_block = var.cidr_main
  tags ={
    "Name" = "${var.name}-vpc"
  }
}

# 가용영역 a, c의 public subnet
resource "aws_subnet" "jelee_pub" {
  count = length(var.cidr_public) #2
  vpc_id            = aws_vpc.jelee_vpc.id
  cidr_block        = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}

# 가용영역 a, c의 private subnet
resource "aws_subnet" "jelee_pri" {
  count =length(var.cidr_private) #2
  vpc_id            = aws_vpc.jelee_vpc.id
  cidr_block        = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava[count.index]}"
  }
}

  # 가용영역 a, c의 private DB subnet
  resource "aws_subnet" "jelee_pridb" {
    count=length(var.cidr_privatedb)
    vpc_id            = aws_vpc.jelee_vpc.id
    cidr_block        = var.cidr_privatedb[count.index]
    availability_zone = "${var.region}${var.ava[count.index]}"
    tags = {
      "Name" = "${var.name}-pridb${var.ava[count.index]}"
    }
  }


