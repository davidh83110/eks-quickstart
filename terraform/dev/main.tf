

resource "aws_eks_cluster" "main" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks_service_role.arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    security_group_ids      = [ aws_security_group.master.id, data.terraform_remote_state.vpc.outputs.office_sg_id ]
    subnet_ids              = [ data.terraform_remote_state.vpc.outputs.subnet_app_a_id, data.terraform_remote_state.vpc.outputs.subnet_app_b_id ]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  depends_on = [
      aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
      aws_iam_role_policy_attachment.amazon_eks_service_policy,
      aws_cloudwatch_log_group.cluster
  ]
}

## Group Name Cannot Be Changed.
resource "aws_cloudwatch_log_group" "cluster" {
    name = "/aws/eks/${var.cluster_name}/cluster"
    retention_in_days = 7
}