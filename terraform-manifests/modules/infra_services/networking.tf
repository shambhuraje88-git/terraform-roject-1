data "aws_availability_zones" "available" {}

resource "random_id" "random" {
  byte_length = 2
}

resource "aws_vpc" "terraform_test_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.cloud_env}_terraform_test_vpc"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "terraform_test_internet_gateway" {
  vpc_id = aws_vpc.terraform_test_vpc.id

  tags = {
    Name = "${var.cloud_env}_terraform_test_internet_gateway"
  }
}

resource "aws_route_table" "terraform_public_rt" {
  vpc_id = aws_vpc.terraform_test_vpc.id

  tags = {
    Name = "${var.cloud_env}_terraform_test_public_route_table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.terraform_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_test_internet_gateway.id
}

resource "aws_default_route_table" "terraform_private_rt" {
  default_route_table_id = aws_vpc.terraform_test_vpc.default_route_table_id

  tags = {
    Name = "${var.cloud_env}_terraform_private_rt"
  }
}

resource "aws_subnet" "terraform_public_test_subnet" {
  count                   = 2
  //count                   = length(var.public_cidrs)

