output "kubectl_config" {
  value = "${local.kubeconfig}"
}

output "EKS_ConfigMap" {
  value = "${local.eks_configmap}"
}