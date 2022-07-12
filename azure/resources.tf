# All resources are described here


resource "azurerm_resource_group" "rg" {
  name     = "${var.workspace_env}-myTFResourceGroup"
  location = "westus2"
  tags     = local.tags
}


# Create a virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.workspace_env}-myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

