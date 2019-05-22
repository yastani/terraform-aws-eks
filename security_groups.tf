#--------------------------------------------------------------
# Security Group for EKS Cluster Master
# リソース名の命名規則は (allow|deny)-(protocol)-(from|to)-(target)
#--------------------------------------------------------------
resource "aws_security_group" "allow-https-from-eks-cluster-master" {
  depends_on = ["aws_vpc.vpc"]

  name        = "eks-cluster-master"
  description = "EKS cluster master"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}eks-master-sg"
  }
}

#--------------------------------------------------------------
# Security Group for EKS Cluster Nodes
# リソース名の命名規則は (allow|deny)-(protocol)-(from|to)-(target)
# マスターにはkubectlを行うためにTCP443のIngressとTCPのレジスタードポート及びエフェメラルポート（つまりTCP1025～65535）のEgressが必要
# https://techblog.ap-com.co.jp/entry/2018/12/06/141104
#--------------------------------------------------------------
resource "aws_security_group" "allow-ephemeral-ports-from-cluster-nodes" {
  depends_on = [
    "aws_vpc.vpc",
    "aws_security_group.allow-https-from-eks-cluster-master"
  ]

  name        = "eks-cluster-nodes"
  description = "EKS cluster nodes"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"

    security_groups = ["${aws_security_group.allow-https-from-eks-cluster-master.id}"]
  }

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port   = 1025
    to_port     = 65535
    protocol    = "udp"

    security_groups = ["${aws_security_group.allow-https-from-eks-cluster-master.id}"]
  }

  ingress {
    description = "Allow inter pods communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}eks-nodes-sg"
  }
}