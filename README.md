# DoubleCloud GCP Bring Your Own Cloud terraform module

Terraform module which creates GCP resources to bring them into DoubleCloud.

## Usage
```hcl
module "byoc" {
  source = "doublecloud/doublecloud-byoc/gcp"

  ipv4_cidr = "196.168.42.0/24"
}

resource "doublecloud_network" "gcp" {
  project_id = var.project_id
  name = "my-aws-network"
  region_id  = module.byoc.region_id
  cloud_type = "gcp"
  gcp = {
    network_name = module.byoc.network_name
    subnetwork_name = module.byoc.subnetwork_name
    project_name   = module.byoc.project_name
    service_account_email = module.byoc.service_account_email
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.44.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.44.1 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.doublecloud](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.byoc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_custom_role.byoc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.byoc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.byoc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_policy.byoc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_policy) | resource |
| [time_sleep.avoid_gcp_race](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_iam_policy.access_control](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activate_google_apis"></a> [activate\_google\_apis](#input\_activate\_google\_apis) | Activate Google APIs or not | `bool` | `true` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account where new project should be attached | `string` | `""` | no |
| <a name="input_create_project"></a> [create\_project](#input\_create\_project) | Create new project for DoubleCloud | `bool` | `true` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID where new project should be created | `string` | `null` | no |
| <a name="input_ipv4_cidr"></a> [ipv4\_cidr](#input\_ipv4\_cidr) | Valid IPv4 CIDR block for VPC | `string` | `"10.10.0.0/16"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Network name where create resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where to create resources | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Display name for a new project | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where create resources | `string` | n/a | yes |
| <a name="input_role_id"></a> [role\_id](#input\_role\_id) | The camel case role ID to create | `string` | n/a | yes |
| <a name="input_role_title"></a> [role\_title](#input\_role\_title) | A human-readable title for the role | `string` | n/a | yes |
| <a name="input_service_account_display_name"></a> [service\_account\_display\_name](#input\_service\_account\_display\_name) | Display name for service account | `string` | n/a | yes |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID | `string` | n/a | yes |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | Subnetwork name where create resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the created Network. DoubleCloud resources will be created in this Network. |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | GCP project ID where resources will be created. |
| <a name="output_region_id"></a> [region\_id](#output\_region\_id) | GCP Region where resources will be created. |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | Email of the Service Account that has permissions to create resources in the project. |
| <a name="output_subnetwork_name"></a> [subnetwork\_name](#output\_subnetwork\_name) | Name of the created Subnetwork. DoubleCloud resources will be created in this Subnetwork. |
<!-- END_TF_DOCS -->