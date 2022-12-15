output "spring_app_id" {
  value = azurerm_spring_cloud_app.cqrs-app.id
}

output "spring_app_fqdn" {
  value = azurerm_spring_cloud_app.cqrs-app.url
}