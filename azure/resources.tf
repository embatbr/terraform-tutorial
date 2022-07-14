# All resources are described here


# Resource group

resource "azurerm_resource_group" "rg" {
  name     = "${local.deployment_env}-myTFResourceGroup"
  location = "westus2"

  tags     = local.tags
}

resource "azurerm_resource_group" "rg-2" {
  name     = "${local.deployment_env}-anotherRG"
  location = "westus2"

  tags     = local.tags
}


# Create a virtual network

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.deployment_env}-myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags                = local.tags
}

