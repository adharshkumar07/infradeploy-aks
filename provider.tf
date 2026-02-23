# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.61.0"
    }
  }

  # 🔷 Remote state: Azure Storage backend
  backend "azurerm" {
    # ⬇️ Replace these with your actual state storage details
    resource_group_name  = "github-actions"            # e.g., the RG where your state storage lives
    storage_account_name = "githubremotebackend"    # must be globally unique, lowercase
    container_name       = "test-container"               # blob container name
    key                  = "prod.tfstate"          # path/name for the state file in the container
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # You can keep this if you want to force a specific subscription,
  # but since your GitHub Actions exports ARM_SUBSCRIPTION_ID,
  # Terraform will pick it up automatically. Prefer environment variable.
  # If you keep it, make sure it matches your ARM_SUBSCRIPTION_ID.
  # subscription_id = "bad976a3-efdf-4d47-b37c-2eaf2b10b6ec"
}
