resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


