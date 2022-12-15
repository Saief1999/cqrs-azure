# Storage account, needed for the runtime of the azure function


resource "random_string" "cqrs-storage-account-random" {
  length = 4
  upper  = false
  special = false
}

resource "azurerm_storage_account" "cqrs-storage-account" {
  name                     = "${var.env}cqrsstoracc${random_string.cqrs-storage-account-random.result}"
  resource_group_name      = var.cqrs_rg_name
  location                 = var.cqrs_rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Insights of the Azure function
resource "azurerm_application_insights" "cqrs-function-application-insights" {
  name                = "${var.env_prefix}-function-application-insights"
  location            = var.cqrs_rg_location
  resource_group_name = var.cqrs_rg_name
  application_type    = "Node.JS"
}

# Service Plan , needed by the Azure function
resource "azurerm_service_plan" "cqrs-function-service-plan" {
  name                = "${var.env_prefix}-function-service-plan"
  resource_group_name = var.cqrs_rg_name
  location            = var.cqrs_rg_location
  os_type             = "Linux"
  # Set Service plan to Consumption Plan (Pay as you go, don't pay when no function are there)
  sku_name = "Y1"
}

# Actual Azure function app, where we deploy the list of our functions
resource "azurerm_linux_function_app" "cqrs-function-app" {
  name                = "${var.env_prefix}-function-app"
  resource_group_name = var.cqrs_rg_name
  location            = var.cqrs_rg_location
  service_plan_id     = azurerm_service_plan.cqrs-function-service-plan.id

  storage_account_name       = azurerm_storage_account.cqrs-storage-account.name
  storage_account_access_key = azurerm_storage_account.cqrs-storage-account.primary_access_key

  # app_settings = {
  #   "WEBSITE_RUN_FROM_PACKAGE" = "",
  #   "FUNCTIONS_WORKER_RUNTIME" = "node"
  # }

  app_settings = {
    "elasticsearch_uri" = var.elasticsearch_uri
  }

  site_config {
    application_insights_key = azurerm_application_insights.cqrs-function-application-insights.instrumentation_key
    application_stack {
      node_version = 18
    }
    use_32_bit_worker = false
  }

  functions_extension_version = "~4"

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["WEBSITE_MOUNT_ENABLED"],
      tags, # Changed by Azure for some reason
    ]
  }
}
