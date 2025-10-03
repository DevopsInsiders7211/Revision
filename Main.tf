terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Backendrg"
    storage_account_name = "storageaccount7211"
    container_name       = "rishicontainer"
    key                  = "terraform.tfstate"
  }

}
provider "azurerm" {
  features {}
  subscription_id = "c7389b7c-212f-4f63-a992-172d719df867"
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
