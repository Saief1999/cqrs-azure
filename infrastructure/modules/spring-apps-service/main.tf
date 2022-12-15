resource "azurerm_application_insights" "cqrs-appinsights" {
  name                = "${var.env_prefix}-appinsights"
  resource_group_name = var.cqrs_rg_name
  location            = var.cqrs_rg_location
  application_type    = "web"
}

resource "azurerm_spring_cloud_service" "cqrs-spring-cloud" {
  name                = "${var.env_prefix}-springcloud"
  resource_group_name = var.cqrs_rg_name
  location            = var.cqrs_rg_location
  sku_name            = "S0"

  config_server_git_setting {
    uri   = "https://github.com/Saief1999/cqrs-config-repo"
    label = "main"
  }

  trace {
    connection_string = azurerm_application_insights.cqrs-appinsights.connection_string
    sample_rate       = 10.0
  }

  tags = {
    Env = var.env
  }
}

# Create the Microservices
module "spring-apps-service" {
  for_each = toset([
    # "registry-server",
    # "configuration-server",
    "search-microservice",
    "upsert-microservice",
    # "gateway-service"
  ])

  source             = "../spring-apps-app"

  env                = var.env
  cqrs_rg_name       = var.cqrs_rg_name
  cloud_service_name = azurerm_spring_cloud_service.cqrs-spring-cloud.name
  app_name           = each.key
}

# Create redis Cache
module "redis-cache" {
  source = "../redis-cache"

  env_prefix       = var.env_prefix
  cqrs_rg_name     = var.cqrs_rg_name
  cqrs_rg_location = var.cqrs_rg_location
}

# Create Redis association with search microservice
resource "azurerm_spring_cloud_app_redis_association" "example" {
  name                = "${var.env_prefix}-redis-bind"
  spring_cloud_app_id = module.spring-apps-service["search-microservice"].spring_app_id
  redis_cache_id      = module.redis-cache.redis_cache_id
  redis_access_key    = module.redis-cache.redis_access_key
  ssl_enabled         = true
}
