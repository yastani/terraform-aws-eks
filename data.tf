data "aws_availability_zones" "azs" {}

data "aws_ami" "eks-node-ami" {
  most_recent = true
  owners      = ["602401143452"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${lookup(var.eks_cluster, "default.version")}-*"]
  }
}
