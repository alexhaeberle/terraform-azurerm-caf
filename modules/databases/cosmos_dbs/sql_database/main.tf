locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

output "database_name" {
  value = azurerm_cosmosdb_sql_container.container.name
}
