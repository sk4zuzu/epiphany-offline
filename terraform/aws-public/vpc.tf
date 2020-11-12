resource "aws_vpc" "aws-public" {
  cidr_block = var.cidr_block

  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = random_id.aws-public.hex
  }
}

resource "aws_internet_gateway" "aws-public" {
  vpc_id = aws_vpc.aws-public.id

  tags = {
    Name = random_id.aws-public.hex
  }
}

resource "aws_subnet" "aws-public" {
  vpc_id = aws_vpc.aws-public.id

  cidr_block = cidrsubnet(var.cidr_block, 8, 240)  # 10.0.240.0/24

  tags = {
    Name = random_id.aws-public.hex
  }
}

resource "aws_route_table" "aws-public" {
  vpc_id = aws_vpc.aws-public.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-public.id
  }

  tags = {
    Name = random_id.aws-public.hex
  }
}

resource "aws_route_table_association" "aws-public" {
  subnet_id      = aws_subnet.aws-public.id
  route_table_id = aws_route_table.aws-public.id
}
