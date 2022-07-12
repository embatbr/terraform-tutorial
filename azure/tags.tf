locals {
  # Tags to flag Terraform-created resources

  tags = {
    "managed-by"     = "terraform"
    "deployment-env" = local.deployment_env
  }
}
