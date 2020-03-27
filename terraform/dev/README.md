## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| AWS\_REGION | n/a | `string` | `"ap-northeast-1"` | no |
| cluster\_name | n/a | `any` | n/a | yes |
| enabled\_cluster\_log\_types | n/a | `list` | <pre>[<br>  "api"<br>]</pre> | no |
| endpoint\_private\_access | n/a | `string` | `"true"` | no |
| endpoint\_public\_access | n/a | `string` | `"true"` | no |
| kubernetes\_version | n/a | `string` | `"1.15"` | no |
| node\_desired\_capacity | n/a | `any` | n/a | yes |
| node\_disk\_size | n/a | `any` | n/a | yes |
| node\_instance\_type | n/a | `any` | n/a | yes |
| node\_max\_capacity | n/a | `any` | n/a | yes |
| node\_min\_capacity | n/a | `any` | n/a | yes |
| public\_access\_cidrs | White list for which CIDR can public access this cluster | `list` | <pre>[<br>  "61.220.65.15/32"<br>]</pre> | no |

## Outputs

No output.

