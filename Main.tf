terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "App_RG"
    storage_account_name = "appstg"
    container_name       = "appcontainer"
    key                  = "terraform.tfstate"
  }

}
provider "azurerm" {
  features {}
  subscription_id = "88fc7642-e677-4cd7-b276-4d2f8cc6ad1d"
}
resource "azurerm_resource_group" "motorg" {
  name     = "MotoRG"
  location = "East US"
}
resource "azurerm_storage_account" "motoacc" {
  name                     = "motostorageaccount98"
  resource_group_name      = "MotoRG"
  location                 = "West US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.motorg ]
}
resource "azurerm_storage_container" "motocontainer" {
  name                  = "moto-container"
  storage_account_id    = azurerm_storage_account.motoacc.id
  container_access_type = "private"
  depends_on = [azurerm_storage_account.motoacc]
}
