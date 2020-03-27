variable "AWS_REGION" {
    default = "ap-northeast-1"
}

variable "cluster_name" {}

variable "kubernetes_version" {
    default = "1.15"
}

variable "enabled_cluster_log_types" {
    type = list
    default = ["api"]
}

variable "endpoint_private_access" {
    default = "true"
}

variable "endpoint_public_access" {
    default = "true"
}

variable "public_access_cidrs" {
    type = list
    default = [ "61.220.65.15/32" ]
    description = "White list for which CIDR can public access this cluster"
}

variable "node_desired_capacity" {}
variable "node_max_capacity" {}
variable "node_min_capacity" {}
variable "node_disk_size" {}
variable "node_instance_type" {}
