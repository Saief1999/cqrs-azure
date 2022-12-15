module "networking" {
  source     = "./modules/networking"
  env_prefix = local.env_prefix
}

module "cosmos-db" {
  source           = "./modules/cosmos-db"
  env_prefix       = local.env_prefix
  cqrs_rg_name     = module.networking.cqrs_rg_name
  cqrs_rg_location = module.networking.cqrs_rg_location
}

module "elasticsearch" {
  source           = "./modules/elasticsearch"
  env              = var.env
  env_prefix       = local.env_prefix
  cqrs_rg_name     = module.networking.cqrs_rg_name
  cqrs_rg_location = module.networking.cqrs_rg_location
}

module "spring-apps-service" {
  source           = "./modules/spring-apps-service"
  env_prefix       = local.env_prefix
  env              = var.env
  cqrs_rg_name     = module.networking.cqrs_rg_name
  cqrs_rg_location = module.networking.cqrs_rg_location
}

module "event-synchronization" {
  source            = "./modules/event-synchronization"
  env_prefix        = local.env_prefix
  env               = var.env
  cqrs_rg_id        = module.networking.cqrs_rg_id
  cqrs_rg_name      = module.networking.cqrs_rg_name
  cqrs_rg_location  = module.networking.cqrs_rg_location
  elasticsearch_uri = module.elasticsearch.elasticsearch_uri
}
