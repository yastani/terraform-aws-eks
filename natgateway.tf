#--------------------------------------------------------------
# Elastic IP
#--------------------------------------------------------------
resource "aws_eip" "natgateway_c" {
  vpc = true

  tags {
    Name = "${var.prefix}natgateway-c-eip"
  }
}

#--------------------------------------------------------------
# NAT GATEWAY
#--------------------------------------------------------------
resource "aws_nat_gateway" "natgateway_c" {
  allocation_id = "${aws_eip.natgateway_c.id}"
  subnet_id     = "${aws_subnet.priv_subnet_c.id}"

  tags {
    Name = "${var.prefix}natgateway-c"
  }
}