## Resources Naming
variable "node_group_name" {}

variable "cluster_name" {}



## Role and Networking
variable "node_role_arn" {}  

variable "subnet_ids" {
    type = list
}

variable "security_group_ids" {
    type = list
}



## Capacity
variable "desired_capacity" {
    default = 2
}

variable "max_capacity" {}

variable "min_capacity" {}



## Instance Level
variable "disk_size" {
    default = 20
}

variable "instance_type" {
    type = string
    default = "t3.medium"
}

variable "ami_release_version" {
    default = "latest"
}

variable "ssh_key_pair" {}


## Dependiency
variable "node_group_depends_on" {
    type = list
}

variable "node_tags" {
    type = map
}

variable "labels" {}