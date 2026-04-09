# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    use_azuread_auth     = true # Can also be set via `ARM_USE_AZUREAD` environment variable.
    subscription_id      = ""
    tenant_id            = ""                       # Can also be set via `ARM_TENANT_ID` environment variable.
    client_id            = ""                       # Can also be set via `ARM_CLIENT_ID` environment variable.
    client_secret        = ""                       # Can also be set via `ARM_CLIENT_SECRET` environment variable.
    storage_account_name = "stopstapocazassedev002" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "sbx.terraform.tfstate"  # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}
provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
    # key_vault {
    #   recover_soft_deleted_key_vaults = true
    #   purge_soft_delete_on_destroy    = false
    # }
  }
}

# provider "azurerm" {
#   alias                      = "hub"
#   tenant_id                  = var.tenant_id
#   subscription_id            = var.subscription_hub_id
#   client_id                  = var.client_id
#   client_secret              = var.client_secret
#   # skip_provider_registration = true #depricated
#   features {}
# }
