output "cosmosdb_connectionstrings" {
  value = azurerm_cosmosdb_account.cqrs-db-acc.connection_strings
}

output "cosmosdb_dbname" {
  value = azurerm_cosmosdb_mongo_database.cqrs-mongodb.name
}
