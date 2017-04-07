provider "aws" {
  region = "eu-central-1"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "grafino_vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "grafino_vpc"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "grafino_igw" {
  vpc_id = "${aws_vpc.grafino_vpc.id}"

  tags {
    Name = "grafino_igw"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "grafino_rt" {
  route_table_id         = "${aws_vpc.grafino_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.grafino_igw.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "grafino_sub" {
  vpc_id                  = "${aws_vpc.grafino_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "grafino_sub"
  }
}

resource "aws_security_group" "grafino-sec-group" {
  name        = "grafino-sec-group"
  description = "grafino-sec-group"
  vpc_id      = "${aws_vpc.grafino_vpc.id}"

  tags {
    Name = "grafino-sec-group"
  }

  # SSH access from anywhere
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "grafino_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "grafino_instance" {
  count                  = 1
  ami                    = "ami-e4c63e8b"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.grafino_key.id}"
  subnet_id              = "${aws_subnet.grafino_sub.id}"
  vpc_security_group_ids = ["${aws_security_group.grafino-sec-group.id}"]

  tags {
    Name = "grafino_instance"
  }

  # User data scripts and cloud-init directives only run during the first boot cycle when an instance is launched.
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > hello.txt
            EOF
}
