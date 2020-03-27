## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ami\_release\_version | n/a | `string` | `"latest"` | no |
| cluster\_name | n/a | `any` | n/a | yes |
| desired\_capacity | # Capacity | `number` | `2` | no |
| disk\_size | # Instance Level | `number` | `20` | no |
| instance\_type | n/a | `string` | `"t3.medium"` | no |
| max\_capacity | n/a | `any` | n/a | yes |
| min\_capacity | n/a | `any` | n/a | yes |
| node\_group\_depends\_on | # Dependiency | `list` | n/a | yes |
| node\_group\_name | # Resources Naming | `any` | n/a | yes |
| node\_role\_arn | # Role and Networking | `any` | n/a | yes |
| security\_group\_ids | n/a | `list` | n/a | yes |
| ssh\_key\_pair | n/a | `any` | n/a | yes |
| subnet\_ids | n/a | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| node\_group | n/a |

