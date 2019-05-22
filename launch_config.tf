locals {
  userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint "${aws_eks_cluster.eks-cluster.endpoint}" --b64-cluster-ca "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}" "${aws_eks_cluster.eks-cluster.name}"
USERDATA
}

resource "aws_launch_configuration" "eks-config" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.eks-node.id}"
  image_id                    = "${data.aws_ami.eks-node-ami.image_id}"
  instance_type               = "t2.micro"
  name_prefix                 = "eks-node"
  key_name                    = "tutorial-aws-eks"
  enable_monitoring           = false

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }

  security_groups  = ["${aws_security_group.allow-ephemeral-ports-from-cluster-nodes.id}"]
  user_data_base64 = "${base64encode(local.userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}