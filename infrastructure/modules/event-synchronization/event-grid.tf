resource "azurerm_eventgrid_topic" "cqrs-topic" {
  name                = "${var.env_prefix}-eventgrid-topic"
  location            = var.cqrs_rg_location
  resource_group_name = var.cqrs_rg_name

  tags = {
    environment = var.env
  }
}

# resource "azurerm_eventgrid_event_subscription" "cqrs-event-subscription" {
#   name  = "${var.env_prefix}-eventgrid-subscription"
#   scope = azurerm_eventgrid_topic.cqrs-topic.id

#   event_delivery_schema = "EventGridSchema"

#   azure_function_endpoint {
#     function_id                       = "${azurerm_linux_function_app.cqrs-function-app.id}/functions/${local.sync_function_name}"
#     max_events_per_batch              = 1
#     preferred_batch_size_in_kilobytes = 64
#   }
# }
