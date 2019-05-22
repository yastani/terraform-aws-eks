#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = "${lookup(var.vpc, "primary.vpc_cidr")}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.prefix}vpc"
  }
}

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  depends_on = ["aws_vpc.vpc"]

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.prefix}igw"
  }
}