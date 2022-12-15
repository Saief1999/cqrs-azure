# Create a resource group
resource "azurerm_resource_group" "cqrs-rg" {
  name     = "${var.env_prefix}-rg"
  location = "West Europe"
}

