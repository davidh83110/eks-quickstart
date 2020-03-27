## =================ALB-Ingress-Controller-Role-Policy================================
## This Policy is for ALB Ingress Controller using. (with OIDC)
## https://docs.aws.amazon.com/zh_tw/eks/latest/userguide/alb-ingress.html

resource "aws_iam_policy" "alb_ingress" {
    name = "ALBIngressControllerIAMPolicy"
    policy = file("${path.module}/../policy/alb_ingress_policy_v1.1.6.json")
}


resource "aws_iam_role" "alb_ingress" {
  name               = "${var.cluster_name}-eks-alb-ingress-controller"
  assume_role_policy = templatefile("${path.module}/../policy/oidc_assume_role_policy.json", 
    { 
      OIDC_ARN = aws_iam_openid_connect_provider.oidc_provider.arn, 
      OIDC_URL = replace(aws_iam_openid_connect_provider.oidc_provider.url, "https://", ""), 
      NAMESPACE = "kube-system", 
      SA_NAME = "alb-ingress-controller"
    })

  tags = {
      "ServiceAccountName"      = "alb-ingress-controller"
      "ServiceAccountNameSpace" = "kube-system"
    }
}


resource "aws_iam_role_policy_attachment" "alb_ingress" {
  policy_arn = aws_iam_policy.alb_ingress.arn
  role       = aws_iam_role.alb_ingress.name
}


output "alb_ingress_role_arn" {
    value = aws_iam_role.alb_ingress.arn
}