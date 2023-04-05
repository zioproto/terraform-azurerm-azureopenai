# terraform-azurerm-azureopenai
Azure OpenAI Terraform Module and Samples

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi)             | >= 1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | ~> 3.0   |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.0   |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0  |
| <a name="provider_random"></a> [random](#provider\_random)    | >= 3.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                | Type        |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account)                 | resource    |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)                   | resource    |
| [random_integer.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer)                                       | resource    |
| [azurerm_private_dns_zone.pe_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.pe_vnet_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)              | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                    | data source |
| [azurerm_subnet.pe_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet)                               | data source |

## Inputs

| Name                                                                                                                                   | Description                                                                                      | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Default                          | Required |
|----------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name)                                                   | Name of the application.                                                                         | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `""`                             |    no    |
| <a name="input_azureopenai_account_name"></a> [azureopenai\_account\_name](#input\_azureopenai\_account\_name)                         | Name of the OpenAI account.                                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `""`                             |    no    |
| <a name="input_azureopenai_customsubdomain_name"></a> [azureopenai\_customsubdomain\_name](#input\_azureopenai\_customsubdomain\_name) | Name of the OpenAI account custom subdomain.                                                     | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `""`                             |    no    |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name)                                  | Azure OpenAI account custom subdomain name.                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `""`                             |    no    |
| <a name="input_environment"></a> [environment](#input\_environment)                                                                    | Environment of the application.                                                                  | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `""`                             |    no    |
| <a name="input_location"></a> [location](#input\_location)                                                                             | Azure OpenAI deployment region. Set this variable to `null` would use resource group's location. | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | n/a                              |   yes    |
| <a name="input_network_acls_default_action"></a> [network\_acls\_default\_action](#input\_network\_acls\_default\_action)              | Azure OpenAI account network ACLs default action.                                                | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `"Deny"`                         |    no    |
| <a name="input_pe_subresource"></a> [pe\_subresource](#input\_pe\_subresource)                                                         | Map of subresources to choose appropriate Private Endpoint sub resource                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `"account"`                      |    no    |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name)                                | Map of the private DNS zone to choose approrite Private DNS Zone                                 | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `"privatelink.openai.azure.com"` |    no    |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint)                                                   | Parameters for private endpoint creation                                                         | <pre>map(object({<br>    name                            = string<br>    vnet_rg_name                    = string<br>    vnet_name                       = string<br>    subnet_name                     = string<br>    dns_zone_rg_name                = optional(string, "default")<br>    private_dns_entry_enabled       = optional(bool, false)<br>    dns_zone_group_name             = string<br>    private_service_connection_name = optional(string, "privateserviceconnection")<br>    is_manual_connection            = optional(bool, false)<br>  }))</pre> | `{}`                             |    no    |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)        | Azure OpenAI account public network access enabled.                                              | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `false`                          |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                        | Name of the azure resource group to use. The resource group must exist.                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | n/a                              |   yes    |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name)                                                                           | Azure OpenAI account SKU name.                                                                   | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `"S0"`                           |    no    |

## Outputs

| Name                                                                                | Description                                                    |
|-------------------------------------------------------------------------------------|----------------------------------------------------------------|
| <a name="output_openai_endpoint"></a> [openai\_endpoint](#output\_openai\_endpoint) | The endpoint used to connect to the Cognitive Service Account. |
| <a name="output_openai_key"></a> [openai\_key](#output\_openai\_key)                | The primary access key for the Cognitive Service Account.      |
<!-- END_TF_DOCS -->


# Contributing

Before submitting a pull request, please make sure the following is done:

We provide a docker image to run the pre-commit checks and tests for you: `mcr.microsoft.com/azterraform:latest`

To run the pre-commit task, we can run the following command:

```shell
docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

On Windows Powershell:

```shell
docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

In pre-commit task, we will:

1. Run `terraform fmt -recursive` command for your Terraform code.
2. Run `terrafmt fmt -f` command for markdown files and go code files to ensure that the Terraform code embedded in these files are well formatted.
3. Run `go mod tidy` and `go mod vendor` for test folder to ensure that all the dependencies have been synced.
4. Run `gofmt` for all go code files.
5. Run `gofumpt` for all go code files.
6. Run `terraform-docs` on `README.md` file, then run `markdown-table-formatter` to format markdown tables in `README.md`.

Then we can run the pr-check task to check whether our code meets our pipeline's requirement(We strongly recommend you run the following command before you commit):

```shell
docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pr-check
```

On Windows Powershell:

```shell
docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pr-check
```

To run the e2e-test, we can run the following command:

```text
docker run --rm -v $(pwd):/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

On Windows Powershell:

```text
docker run --rm -v ${pwd}:/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```
