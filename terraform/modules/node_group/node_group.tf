

resource "aws_eks_node_group" "worker" {

  node_group_name = var.node_group_name

  cluster_name  = var.cluster_name
  node_role_arn = var.node_role_arn
  subnet_ids    = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  disk_size       = var.disk_size
  instance_types  = [var.instance_type]
  release_version = var.ami_release_version

  remote_access {
    ec2_ssh_key               = var.ssh_key_pair
    ## This SG assign only for "which SG could ACCESS nodes from 22 port". Normally we will given a SG which allows all internal traffic.
    source_security_group_ids = var.security_group_ids
  }


  tags = merge({
    Name = "eks-worker-private-node"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }, var.node_tags)

  labels = var.labels

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [scaling_config.0.desired_size, node_group_name]
  }

  depends_on = [var.node_group_depends_on]
}