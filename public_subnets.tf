#--------------------------------------------------------------
# Public Subnet of ap-northeast-1c
#--------------------------------------------------------------
resource "aws_subnet" "pub_subnet_c" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "primary.pub_subnet_c_cidr")}"
  availability_zone       = "${data.aws_availability_zones.azs.names[1]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.prefix}${lookup(var.subnet, "primary.pub_subnet_c_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_c" {
  depends_on = [
    "aws_subnet.pub_subnet_c",
    "aws_route_table.pub_rt"
  ]

  subnet_id      = "${aws_subnet.pub_subnet_c.id}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}

#--------------------------------------------------------------
# Public Subnet of ap-northeast-1d
#--------------------------------------------------------------
resource "aws_subnet" "pub_subnet_d" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.subnet, "primary.pub_subnet_d_cidr")}"
  availability_zone       = "${data.aws_availability_zones.azs.names[2]}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.prefix}${lookup(var.subnet, "primary.pub_subnet_d_name")}"
  }
}

resource "aws_route_table_association" "pub_rta_d" {
  depends_on = [
    "aws_subnet.pub_subnet_d",
    "aws_route_table.pub_rt"
  ]

  subnet_id      = "${aws_subnet.pub_subnet_d.id}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}