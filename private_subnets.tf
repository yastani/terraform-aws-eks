#--------------------------------------------------------------
# Private Subnet of ap-northeast-1c
#--------------------------------------------------------------
resource "aws_subnet" "priv_subnet_c" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.subnet, "primary.priv_subnet_c_cidr")}"
  availability_zone = "${data.aws_availability_zones.azs.names[1]}"

  tags {
    Name = "${var.prefix}${lookup(var.subnet, "primary.priv_subnet_c_name")}"
    # EKSを使用する場合、プライベートサブネットにはこのタグを付与する
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_route_table_association" "priv_rta_c" {
  depends_on = [
    "aws_subnet.priv_subnet_c",
    "aws_route_table.priv_rt"
  ]

  subnet_id      = "${aws_subnet.priv_subnet_c.id}"
  route_table_id = "${aws_route_table.priv_rt.id}"
}

#--------------------------------------------------------------
# Private Subnet of ap-northeast-1d
#--------------------------------------------------------------
resource "aws_subnet" "priv_subnet_d" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.subnet, "primary.priv_subnet_d_cidr")}"
  availability_zone = "${data.aws_availability_zones.azs.names[2]}"

  tags {
    Name = "${var.prefix}${lookup(var.subnet, "primary.priv_subnet_d_name")}"
    # EKSを使用する場合、プライベートサブネットにはこのタグを付与する
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_route_table_association" "priv_rta_d" {
  depends_on = [
    "aws_subnet.priv_subnet_d",
    "aws_route_table.priv_rt"
  ]
  subnet_id      = "${aws_subnet.priv_subnet_d.id}"
  route_table_id = "${aws_route_table.priv_rt.id}"
}
