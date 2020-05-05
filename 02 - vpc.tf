resource "aws_vpc" "falcons-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "falcons-vpc"
    Project = "apigw.falcons"
  }
}

resource "aws_subnet" "falcons-subnet-public-1" {
  vpc_id                  = aws_vpc.falcons-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-west-2a"

  tags = {
    Name = "falcons-subnet-public-1"
  }
}

