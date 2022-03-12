terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}


# VPC RESOURCES

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "sample VPC"
  }
}


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "sample_Internet_GTW"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_cidr_block

  tags = {
    Name = "sample Public Subnet"
  }
}


resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "sample Public Route"
  }
}


resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}



#EC2 RESOURCES



resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true
  user_data                   = filebase64("${path.module}/appdata.sh")

  tags = {
    Name = "Hello World Application"
  }
}

resource "aws_security_group" "this" {
  name        = "sample_sg"
  description = "Allow http traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sample_sg"
  }
}