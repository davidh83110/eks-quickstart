# Enable IAM Roles for EKS Service Accounts (IRSA).
# Using OIDC (OpenID Connect) to attach between IAM Roles and EKS Service Accounts.

# The Root CA Thumbprint for an OpenID Connect Identity Provider is currently
# Being passed as a default value which is the same for all regions and
# Is valid until (Jun 28 17:39:16 2034 GMT).
# https://crt.sh/?q=9E99A48A9960B14926BB7F3B02E22DA2B0AB7280
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html
# https://github.com/terraform-providers/terraform-provider-aws/issues/10104


resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]

  # it's thumbprint won't change for many years :)
  # https://github.com/terraform-providers/terraform-provider-aws/issues/10104
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  url             = aws_eks_cluster.main.identity.0.oidc.0.issuer
}


output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}