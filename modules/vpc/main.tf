resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Taylor-tf-vpc"
    ENV  = var.env
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "taylor-tf-pub1-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr

  tags = {
    Name = "taylor-tf-pub2-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "public3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet3_cidr

  tags = {
    Name = "taylor-tf-pub2-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet4_cidr

  tags = {
    Name = "taylor-tf-priv1-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet5_cidr

  tags = {
    Name = "taylor-tf-priv2-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet6_cidr

  tags = {
    Name = "taylor-tf-priv3-subnet"
    ENV  = var.env
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "taylor-tf-gw"
  }
}

resource "aws_eip" "nat_eip" {
  vpc      = true

  tags = {
    Name = "taylor-tf-NAT-gateway-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "taylor-tf-NAT-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "taylor-tf-Public"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "taylor-tf-Private"
  }
}

resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "priv1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private_rt.id
}
