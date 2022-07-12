# terraform-tutorial


## Azure - Terraform tutorial

Following instructions from this [tutorial](https://learn.hashicorp.com/collections/terraform/azure-get-started).


### Step 1 - Connecting to Azure

1. Authenticate using `az login`. Save the output in *.credentials/az-login.output.json*;
2. Set the account with `az account set --subscription "<SUBSCRIPTION_ID>"` with the value in field `id` from previous item's output;
3. Create a Service Principal with `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"`. Save the output in *.credentials/create-service-principal.output.json*
4. Export the variables:
    - `export ARM_CLIENT_ID="<APPID_VALUE>"`
    - `export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"`
    - `export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"`
    - `export ARM_TENANT_ID="<TENANT_VALUE>"`
5. Write the configuration, as shown in the tutorial.


### Step 2 - Store the state remotely

Once defined the backend in *_backend.tf*, just do `terraform init` and it will
create a .tfstate file in the designated place.

There is no need to specify an access key, since Terraform is using azure cli.

For more info, see [the docs](https://www.terraform.io/language/settings/backends/azurerm).


#### Outside Terraform

Some resources may need to be placed out of Terraform, such as resource groups,
storage accounts and etc. related to store the state remotely. These are:

- **(dev|qa|prod)-rg-westus2-terraform** (resource group)
- **tftutoembatbr(dev|qa|prod)** (storage account)
- **terraform-state** (blob container, one for each env)
- **(dev|qa|prod)-terraform.tfstate** (key, one for each env)


### Step 3 - Use different Workspaces

1. `terraform init` (do it once)
2. `terraform workspace new <workspace_name>` (do it for each env)
3. `terraform (plan|apply)` (do it for each env)

This way environments **dev** and **qa** can be created and provisioned. For **prod**,
ideally it should just be executed the item 2 and item 3 shouldn't be allowed.

For more, read [this](https://danielwertheim.se/terraform-workspaces-and-remote-state-in-azure/).
