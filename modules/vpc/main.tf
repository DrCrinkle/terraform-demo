resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Taylor-tf-vpc"
    ENV  = var.env
  }
}

resource "aws_subnet" "public" {
  count      = 3
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)

  tags = {
    Name = "taylor-tf-pub${count.index}-subnet"
    ENV  = var.env
  }
}

resource "aws_subnet" "private" {
  count      = 3
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index+3)

  tags = {
    Name = "taylor-tf-priv${count.index}-subnet"
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
  subnet_id     = aws_subnet.public[1].id

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

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
