output "cqrs_microservice_endpoints" {
  value = values(module.spring-apps-service)[*].spring_app_fqdn
}