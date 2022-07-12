# Configures the Terraform Backend State File

terraform {
  backend "azurerm" {
    storage_account_name = "terraformtutorialembatbr"
    container_name       = "terraform-state"
    key                  = "azure.tfstate"
    subscription_id      = "41f5ab0c-7fb5-4144-82ab-31491b47a479"
    resource_group_name  = "rg-westus2-terraform"
    tenant_id            = "ddd290f8-76db-4ddd-b7e8-f57592ba9680"
    snapshot             = true
  }
}
