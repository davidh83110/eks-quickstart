## EKS
The EKS cluster and related resources are all created by Terraform.
The Terraform project contains `EKS Cluster`, `Node Group`, `IAM Roles/Policies`, `ECR` and `OIDC & IRSA`.

![arc](https://live.staticflickr.com/65535/49751615113_ff81d31f5c_k.jpg)

```bash
## Go into the EKS project directory.
cd terraform/${ENV}
// e.g. cd terraform/staging

## If you wanna check the status of those resources, please run the following commands.
make init && make plan

## If you wanna deploy the changes.
make apply
``` 


## EKS Add-On (Ansible Playbooks)
On the `eks-addons` this directory, we are going to install some of the following plugins in `Ansible Playbooks`.

- Metrics Server
- Kubernetes Dashboard
- EKS Admin ServiceAccount
- ALB Ingress Controller
- Cluster Autoscaler (CA)
- Prometheus 
- Grafana



## Structure

```
terraform
├── prod
│   └── config
│
├── staging
│   └── config
│
├── dev
│   └── config
│
├── policy
│
└── modules
    └── node_group

```


## Generate Terraform Documents

For MacOS  
```bash
brew install terraform-docs

terraform-docs md . > README.md
```



## Organization User (Cross Account)
If you are an AWS Organization IAM user, please run commands related to AWS through `aws-vault`.

```bash
## For example

aws-vault exec staging -- make init && make plan
```


## How To Access EKS
EKS uses IAM to provide authentication to your Kubernetes cluster, via the `aws eks get-token` or `AWS IAM Authenticator fro Kubernetes`.
But it still relies on the RBAC which native on Kubernetes.  

To follow the best practices of EKS, let's stick to use IAM user to access the cluster. 
After the user created, we will also have to add it on the ConfigMap by `kubectl edit configmap/aws-auth -n kube-system`.
Check the official documentation below. 

[AWS - Managing Users or IAM Roles for your Cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html) 

Following the steps to access this EKS cluster and before we start, please make sure you already added the `Access / Secret Keys` in your `~/.aws/credentials` and corresponding profile on `~/.aws/config`.

A. Check the current IAM user that you are using.
```bash
aws sts get-caller-identity
```

B. Update your `kubeconfig`
```bash
aws eks --region ap-northeast-1 update-kubeconfig --name development
```

C. Check the result!
```bash
kubectl get nodes
```


## User Management
We manage user permission thorough IAM Role, which means we attach a role to aws-auth.yaml in the ConfigMap and add IAM Policy Permission to an IAM Group to allow users in this group can have the same permission(sts:assumeRole) to assume the role to cross-account to another IAM Role in the EKS account and access EKS cluster with RBAC.

The IAM Group will be in root account to associate to an inline policy that allows us to assume role to subaccount's IAM Role to access the EKS cluster.
We can add IAM Users to this group as EKS permission management. The inline policy example is below.

```json
{
	"Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "arn:aws:iam::469596146343:role/exchange-staging-eksAssumeRole",
            "Condition": {
                "ForAnyValue:IpAddress": {
                    "aws:SourceIp": [
                        "61.220.65.15/32"
                    ]
                }
            }
        }
    ]
}
``` 

On the other hand, we have to set up the role associated with aws-auth.yaml in EKS account. There's only one permission this IAM Role needs, that is `eks:DescribeCluster`. 
Users only need this permission to update their kubeconfig through aws cli.

In the `Trusted Relationship`, it must trust the root account (or the account who manages IAM Users). Otherwise, IAM Users will not be able to cross-account through this IAM Role.

The examples of Role inline policy and trusted relationship are below.

```json
Trusted Relationship:
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::072020267081:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}

POLICY (inline):
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "eks:DescribeCluster",
            "Resource": "arn:aws:eks:ap-northeast-1:469596146343:cluster/exchange-staging"
        }
    ]
}
```