### EKS Cluster Security Group, it will apply to resources EKS created suck as nodes.
#
# The Cluster Security Group is a unified security group that is used to control communications between the Kubernetes control plane and compute resources on the cluster. 
# It is applied by default to the Kubernetes control plane managed by Amazon EKS as well as any managed compute resources created through the Amazon EKS API.
#

## ============================== MASTER ======================================
resource "aws_security_group" "master" {
  name        = "${var.cluster_name}-EKS-Master-SG"
  description = "Security Group for EKS cluster"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags        = {
    Name = "${var.cluster_name}-eks-master-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

## ====Outbound====
## Outbound allows all
resource "aws_security_group_rule" "master_egress" {
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.master.id
  type              = "egress"
}


## ====Inbound====
## Inbound allows for whole VPC
resource "aws_security_group_rule" "master_ingress_vpc" {
  description              = "Allow internal traffic"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks              = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
  security_group_id        = aws_security_group.master.id
  type                     = "ingress"
}



## ============================== Nodes ======================================
resource "aws_security_group" "nodes" {
  name        = "${var.cluster_name}-EKS-Nodes-SG"
  description = "Security Group for EKS Node Instances"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags        = {
    Name = "${var.cluster_name}-eks-nodes-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

## ====Outbound====
## Outbound allows all
resource "aws_security_group_rule" "nodes_egress" {
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nodes.id
  type              = "egress"
}


## ====Inbound====
## Inbound allows for whole VPC
resource "aws_security_group_rule" "nodes_ingress_vpc" {
  description              = "Allow the cluster to receive communication from all internal traffic"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks              = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
  security_group_id        = aws_security_group.nodes.id
  type                     = "ingress"
}
