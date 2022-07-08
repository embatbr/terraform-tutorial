# Contains Terraform settings, including the required providers
# Built in provider 'terraform.io/builtin/terraform' provides 'terraform_remote_state' data source

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # shorthand for registry.terraform.io/hashicorp/azurerm
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
  tags     = local.tags
}
