terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {}
}


locals {
  deployment_envs = {
    "dev"  = {}
    "qa"   = {}
    "prod" = {}
  }
}


resource "azurerm_resource_group" "rg" {
  for_each = local.deployment_envs
  name     = "${each.key}-rg-westus2-terraform"
  location = "westus2"
}

resource "azurerm_storage_account" "stacc" {
  for_each                 = local.deployment_envs
  name                     = "stacctuto${each.key}"
  resource_group_name      = azurerm_resource_group.rg[each.key].name
  location                 = azurerm_resource_group.rg[each.key].location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container" {
  for_each              = local.deployment_envs
  name                  = "${each.key}-terraform"
  storage_account_name  = azurerm_storage_account.stacc[each.key].name
  container_access_type = "private"
}
