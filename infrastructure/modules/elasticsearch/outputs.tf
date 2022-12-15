output "elasticsearch_uri" {
  value = "http://${azurerm_container_group.cqrs-es-aci.fqdn}:9200"
}