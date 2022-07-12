# terraform-tutorial


## Azure - Terraform tutorial

Following instructions from this [tutorial](https://learn.hashicorp.com/collections/terraform/azure-get-started).


### Step 1 - Building infrastructure

1. Authenticate using `az login`. Save the output in *.credentials/az-login.output.json*;
2. Set the account with `az account set --subscription "<SUBSCRIPTION_ID>"` with the value in field `id` from previous item's output;
3. Create a Service Principal with `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"`. Save the output in *.credentials/create-service-principal.output.json*
4. Export the variables:
    - `export ARM_CLIENT_ID="<APPID_VALUE>"`
    - `export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"`
    - `export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"`
    - `export ARM_TENANT_ID="<TENANT_VALUE>"`
5. Write the configuration, as shown in the tutorial.


## Outside Terraform

Some resources may need to be placed out of Terraform, such as resource groups,
storage accounts and etc. related to store the state remotely. These are:

- **rg-westus2-terraform** (resource group)
- **terraformtutorialembatbr** (storage account)
- **terraform-state** (blob container)
- **azure.tfstate** (key) (TODO replace it by "(dev|qa|prod).tfstate")
