## https://eksworkshop.com/beginner/091_iam-groups/create-iam-roles/
## Create an IAM Role for access EKS cluster with master permission(admin).
## This Role will also be added in aws-auth in ConfigMap.
## IAM User who wanna access EKS cluster have to be granted permission to assume this role.

## =================eksAdminRole=======================================
## The AWS account id will be hardcoded as Root account ID here, because we supposed to centralize account management in the ROOT account.
resource "aws_iam_role" "eks_admin_role" {
  name               = "${var.cluster_name}-eksAdminRole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.root_account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "${var.mfa_toggle}"
        }
      }
    }
  ]
}
POLICY

}

## Fetch current account ID.
data "aws_caller_identity" "current" {}

## Inline Policy for IAM Role
resource "aws_iam_role_policy" "describe_cluster" {
  name = "DescribeClusterPolicy"
  role = aws_iam_role.eks_admin_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": "eks:DescribeCluster",
        "Resource": "arn:aws:eks:ap-northeast-1:${data.aws_caller_identity.current.account_id}:cluster/${var.cluster_name}"
      }
    ]
  }
  EOF

}
