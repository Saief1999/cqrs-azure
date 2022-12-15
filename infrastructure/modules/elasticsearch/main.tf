resource "azurerm_container_group" "cqrs-es-aci" {
  name                = "${var.env}esaci"
  location            = var.cqrs_rg_location
  resource_group_name = var.cqrs_rg_name
  ip_address_type     = "Public"
  dns_name_label      = "cqrs-dns"
  os_type             = "Linux"

  container {
    name   = "es01"
    image  = "docker.elastic.co/elasticsearch/elasticsearch:8.5.3"
    cpu    = "2"
    memory = "8"

    environment_variables = {
      "ES_SETTING_NODE_NAME" : "es01"
      "ES_SETTING_CLUSTER_NAME" : "local-cluster"
      "ES_SETTING_DISCOVERY_TYPE" : "single-node"
      "ES_SETTING_XPACK_SECURITY_ENABLED" : "false"
    }
    ports {
      port     = 9200
      protocol = "TCP"
    }
  }

  tags = {
    environment = var.env
  }
}