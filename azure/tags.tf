locals {
  # Tags to flag Terraform-created resources

  tags = {
    "managed-by" = "terraform"
    "env"        = var.workspace_env
  }
}
