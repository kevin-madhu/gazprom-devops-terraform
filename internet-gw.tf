resource "aws_internet_gateway" "finava-internet-gw" {
  vpc_id = aws_vpc.finava-vpc.id

  tags  = {
    Name = "finava-internet-gw"
  }
}

resource "aws_route_table" "finava-rt" {
  vpc_id = aws_vpc.finava-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.finava-internet-gw.id
  }

  tags  = {
    Name = "finava-rt"
  }
}

resource "aws_route_table_association" "finava-public-1" {
  route_table_id = aws_route_table.finava-rt.id
  subnet_id = aws_subnet.finava-public-1.id
}

resource "aws_route_table_association" "finava-public-2" {
  route_table_id = aws_route_table.finava-rt.id
  subnet_id = aws_subnet.finava-public-2.id
}

