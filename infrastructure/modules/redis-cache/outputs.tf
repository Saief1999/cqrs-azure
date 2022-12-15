output "redis_cache_id" {
  value = azurerm_redis_cache.cqrs-redis.id
}


output "redis_access_key" {
    value = azurerm_redis_cache.cqrs-redis.primary_access_key
}