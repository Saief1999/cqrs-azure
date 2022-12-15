resource "azurerm_cosmosdb_account" "cqrs-db-acc" {
  name = "${var.env_prefix}-db-account"

  location            = var.cqrs_rg_location
  resource_group_name = var.cqrs_rg_name

  offer_type = "Standard"
  kind       = "MongoDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  geo_location {
    location          = "westus"
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "cqrs-mongodb" {
  name                = "${var.env_prefix}-mongodb"
  resource_group_name = var.cqrs_rg_name
  account_name        = azurerm_cosmosdb_account.cqrs-db-acc.name
}
