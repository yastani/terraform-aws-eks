locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${lookup(var.eks_cluster, "default.cluster_name")}"
KUBECONFIG

  eks_configmap = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

resource "aws_eks_cluster" "eks-cluster" {
  depends_on = [
    "aws_iam_role_policy_attachment.eks-cluster",
    "aws_iam_role_policy_attachment.eks-service",
  ]

  name     = "${lookup(var.eks_cluster, "default.cluster_name")}"
  version  = "${lookup(var.eks_cluster, "default.version")}"
  role_arn = "${aws_iam_role.eks-master.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.allow-https-from-eks-cluster-master.id}"]

    subnet_ids = [
      "${aws_subnet.pub_subnet_c.id}",
      "${aws_subnet.pub_subnet_d.id}",
      "${aws_subnet.priv_subnet_c.id}",
      "${aws_subnet.priv_subnet_d.id}"
    ]
  }
}