# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "falcons-igw" {
  vpc_id = aws_vpc.falcons-vpc.id

  tags = {
    Name = "falcons-igw"
  }
}

# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "falcons-public-crt" {
  vpc_id = aws_vpc.falcons-vpc.id
  route {
    cidr_block = "0.0.0.0/0"                      //associated subnet can reach everywhere
    gateway_id = aws_internet_gateway.falcons-igw.id //CRT uses this IGW to reach internet
  }

  tags = {
    Name = "falcons-public-crt"
  }
}

# route table association for the public subnets
resource "aws_route_table_association" "falcons-crta-public-subnet-1" {
  subnet_id      = aws_subnet.falcons-subnet-public-1.id
  route_table_id = aws_route_table.falcons-public-crt.id
}

# security group
resource "aws_security_group" "ssh-allowed" {
  vpc_id = aws_vpc.falcons-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    // This means, all ip address are allowed to ssh !
    // Do not do it in the production. Put your office or home address in it!
    cidr_blocks = ["0.0.0.0/0"]
  }

  //If you do not add this rule, you can not reach the NGIX
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8880
    to_port     = 8880
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8086
    to_port     = 8086
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-allowed"
  }
}

