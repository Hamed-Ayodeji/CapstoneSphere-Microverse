terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
}

resource "aws_vpc" "vpc" {
  cidr_block              = "10.0.0.0/24"
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id                  = aws_vpc.vpc.id
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet("10.0.0.0/24", 4, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public-route-table" {
  vpc_id                  = aws_vpc.vpc.id
  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  subnet_id               = aws_subnet.subnet.id
  route_table_id          = aws_route_table.public-route-table.id
}

resource "aws_security_group" "public-instance-sg" {
  description   = "Allow SSH ICMP HTTP and HTTPs inbound traffic and all traffic outbound"
  vpc_id        = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH inbound traffic"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ICMP inbound traffic"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}


data "aws_ami" "ubuntu" {
  most_recent             = true
  owners                  = ["099720109477"] # Canonical

  filter {
    name                  = "name"
    values                = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name                  = "virtualization-type"
    values                = ["hvm"]
  }

  filter {
    name                  = "root-device-type"
    values                = ["ebs"]
  }

  filter {
    name                  = "architecture"
    values                = ["x86_64"]
  }
}

resource "tls_private_key" "rsa-key" {
  algorithm               = "RSA"
  rsa_bits                = 4096
}

resource "aws_key_pair" "rsa-key" {
  key_name                = "test-key"
  public_key              = tls_private_key.rsa-key.public_key_openssh
}

resource "local_file" "rsa-key" {
  content                 = tls_private_key.rsa-key.private_key_pem
  filename                = "test-key.pem"
}

resource "aws_instance" "ec2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.2xlarge"
  key_name                = aws_key_pair.rsa-key.key_name
  subnet_id               = aws_subnet.subnet.id
  vpc_security_group_ids  = [aws_security_group.public-instance-sg.id]
  user_data               = file("tester.sh")
}