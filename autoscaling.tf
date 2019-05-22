resource "aws_autoscaling_group" "eks-asg" {
  name                 = "EKS cluster node group"
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  launch_configuration = "${aws_launch_configuration.eks-config.id}"

  vpc_zone_identifier = [
    "${aws_subnet.pub_subnet_c.id}",
    "${aws_subnet.pub_subnet_d.id}",
    "${aws_subnet.priv_subnet_c.id}",
    "${aws_subnet.priv_subnet_d.id}"
  ]

  tag {
    key                 = "Name"
    value               = "eks-node-group"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${lookup(var.eks_cluster, "default.cluster_name")}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "yastani-dev"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "dev"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}