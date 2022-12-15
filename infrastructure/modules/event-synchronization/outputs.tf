output "topic_access_key" {
  value     = azurerm_eventgrid_topic.cqrs-topic.primary_access_key
  sensitive = true
}

output "topic_endpoint" {
  value = azurerm_eventgrid_topic.cqrs-topic.endpoint
}


output "function_app_name" {
  value = azurerm_linux_function_app.cqrs-function-app.name
}

output "function_app_default_hostname" {
  value = azurerm_linux_function_app.cqrs-function-app.default_hostname
}