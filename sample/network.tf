module "vnet" {
  source              = "git::https://github.com/lonegunmanb/terraform-azurerm-subnets.git"
  resource_group_name = azurerm_resource_group.this.name
  subnets = {
    subnet0 = {
      address_prefixes = ["10.52.0.0/16"]
    }
  }
  virtual_network_address_space = ["10.52.0.0/16"]
  virtual_network_location      = "westeurope"
  virtual_network_name          = "vnet"
}