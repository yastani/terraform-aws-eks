resource "aws_iam_role" "eks-master" {
  name = "eks-master"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks-cluster" {
  depends_on = ["aws_iam_role.eks-master"]

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = "${aws_iam_role.eks-master.name}"
}

resource "aws_iam_role_policy_attachment" "eks-service" {
  depends_on = ["aws_iam_role.eks-master"]

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = "${aws_iam_role.eks-master.name}"
}

resource "aws_iam_role" "eks-node" {
  name = "eks-node"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "eks-node" {
  name = "eks-node-role"
  role = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-worker-node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "ec2-container-registry-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "ec2-role-for-ssm" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "${aws_iam_role.eks-node.name}"
}