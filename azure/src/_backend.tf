# Configures the Terraform Backend State File
# TODO try yo use jinja2

terraform {
  backend "azurerm" {
    resource_group_name  = "{{ deployment_env }}-rg-westus2-terraform"
    storage_account_name = "stacctuto{{ deployment_env }}"
    container_name       = "{{ deployment_env }}-terraform"
    key                  = "{{ deployment_env }}-terraform.tfstate"

    subscription_id = "{{ subscription_id }}"
    tenant_id       = "{{ tenant_id }}"
    snapshot        = true
  }
}
