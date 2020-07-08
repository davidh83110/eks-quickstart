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


## ============================== Worker Node ======================================
resource "aws_security_group" "worker" {
  name        = "${var.cluster_name}-EKS-Node-SG"
  description = "Security Group for EKS cluster Worker Node"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags        = {
    Name = "${var.cluster_name}-eks-node-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

## ====Outbound====
## Outbound allows all
resource "aws_security_group_rule" "node_egress" {
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker.id
  type              = "egress"
}


## ====Inbound====
## Inbound allows for whole VPC
resource "aws_security_group_rule" "node_ingress_vpc" {
  description              = "Allow internal traffic"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks              = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
  security_group_id        = aws_security_group.worker.id
  type                     = "ingress"
}

## Inbound allows for office
resource "aws_security_group_rule" "node_ingress_office" {
  description              = "Allow office traffic"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks              = ["61.11.11.11/32"]
  security_group_id        = aws_security_group.worker.id
  type                     = "ingress"
}

## Inbound allows for whole VPC
resource "aws_security_group_rule" "node_ingress_alb_sg" {
  description              = "Allow ALB SG traffic"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = "sg-04d76c9c0063edec3"
  security_group_id        = aws_security_group.worker.id
  type                     = "ingress"
}
