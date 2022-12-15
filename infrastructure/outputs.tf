output "cqrs_rg_name" {
  value = module.networking.cqrs_rg_name
}


output "cosmosdb_connectionstrings" {
  value     = module.cosmos-db.cosmosdb_connectionstrings
  sensitive = true
}

output "cosmosdb_dbname" {
  value = module.cosmos-db.cosmosdb_dbname
}

output "elasticsearch_uri" {
  value = module.elasticsearch.elasticsearch_uri
}

output "spring-service-endpoints" {
  value = module.spring-apps-service.cqrs_microservice_endpoints
}

output "topic_access_key" {
  value     = module.event-synchronization.topic_access_key
  sensitive = true
}

output "topic_endpoint" {
  value = module.event-synchronization.topic_endpoint
}

output "function_app_name" {
  value = module.event-synchronization.function_app_name
}

output "function_app_default_hostname" {
  value = module.event-synchronization.function_app_default_hostname
}