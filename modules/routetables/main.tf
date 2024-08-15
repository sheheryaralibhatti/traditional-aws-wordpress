# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = 2
  subnet_id      = var.public_subnets_id[count.index]
  route_table_id = aws_route_table.public_rt.id
}

# NAT & Private RouteTable
resource "aws_eip" "nat_ip" {
  count = 1
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip[0].id
  subnet_id     = var.public_subnets_id[0]

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = 2
  subnet_id      = var.private_subnets_id[count.index]
  route_table_id = aws_route_table.private_rt.id
}
