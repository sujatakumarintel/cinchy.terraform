data "aws_vpc" "cinchy" {
  id = var.vpc_id
}

resource "aws_subnet" "cinchy" {
  count = 3

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "${var.subnet[count.index]}"
  map_public_ip_on_launch = true
  vpc_id                  = data.aws_vpc.cinchy.id

  tags = tomap({
    "Name"                                     = "subnet${var.clustername}",
    "kubernetes.io/cluster/${var.clustername}" = "shared",
  })
}

data "aws_internet_gateway" "cinchy" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.cinchy.id]
  }
}

resource "aws_route_table" "cinchy" {
  vpc_id = data.aws_vpc.cinchy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.cinchy.id
  }
}

resource "aws_route_table_association" "cinchy" {
  count = 2

  subnet_id      = aws_subnet.cinchy.*.id[count.index]
  route_table_id = aws_route_table.cinchy.id
}
