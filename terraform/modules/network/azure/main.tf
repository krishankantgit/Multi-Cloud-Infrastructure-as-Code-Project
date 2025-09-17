variable "name_prefix" { type = string }
variable "cidr_block"  { type = string }
variable "location"    { type = string }

resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}-vnet"
  address_space       = [var.cidr_block]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

output "vnet_id" { value = azurerm_virtual_network.vnet.id }


