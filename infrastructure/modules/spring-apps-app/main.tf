resource "azurerm_spring_cloud_app" "cqrs-app" {
  name                = var.app_name
  resource_group_name = var.cqrs_rg_name
  service_name        = var.cloud_service_name
  is_public = true
}

resource "azurerm_spring_cloud_java_deployment" "cqrs-app-deployment" {
  name                = "default"
  spring_cloud_app_id = azurerm_spring_cloud_app.cqrs-app.id
  instance_count      = 1
  jvm_options         = "-XX:+PrintGC"
  runtime_version     = "Java_11"

  environment_variables = {
    "Env" : var.env
  }
}

resource "azurerm_spring_cloud_active_deployment" "cqrs-app-active-deployment" {
  spring_cloud_app_id = azurerm_spring_cloud_app.cqrs-app.id
  deployment_name     = azurerm_spring_cloud_java_deployment.cqrs-app-deployment.name
}