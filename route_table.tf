#--------------------------------------------------------------
# Route Table of Public
#--------------------------------------------------------------
resource "aws_route_table" "pub_rt" {
  depends_on = [
    "aws_vpc.vpc",
    "aws_internet_gateway.igw"
  ]

  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.prefix}${lookup(var.route_table, "primary.pub_subnet_route_table_name")}"
  }
}

#--------------------------------------------------------------
# Route Table of Private
#--------------------------------------------------------------
resource "aws_route_table" "priv_rt" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgateway_c.id}"
  }

  tags {
    Name = "${var.prefix}${lookup(var.route_table, "primary.priv_subnet_route_table_name")}"
  }
}