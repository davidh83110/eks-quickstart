## Global
AWS_REGION = "ap-northeast-1"


## EKS
cluster_name = "development"
kubernetes_version = "1.15"
enabled_cluster_log_types = ["api"]
endpoint_private_access = "true"
endpoint_public_access = "true"
public_access_cidrs = [ "0.0.0.0/32" ]

node_key_pair = "dev"

## EKS Node Group
node_desired_capacity = 4
node_max_capacity = 4
node_min_capacity = 4
node_disk_size = 20
node_instance_type = "t3.medium"


## App Node Group Instance
node_app_desired_capacity = 2
node_app_max_capacity = 4
node_app_min_capacity = 2
node_app_disk_size = 20
node_app_instance_type = "m5.large"
