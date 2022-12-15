resource "azurerm_redis_cache" "cqrs-redis" {
  name                = "${var.env_prefix}-redis"
  location            = var.cqrs_rg_location
  resource_group_name = var.cqrs_rg_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
}