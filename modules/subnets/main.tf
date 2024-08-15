# Public Subnet
resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  count = 2

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }
}
