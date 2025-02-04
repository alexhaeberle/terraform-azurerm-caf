terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))

  location = can(var.settings.region) ? var.global_settings.regions[var.settings.region] : try(var.location, local.resource_group.location)
  resource_group = try(
    var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key],
    var.resource_groups[var.settings.lz_key][var.settings.resource_group_key],
    var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key],
    var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key],
    null
  )
  resource_id = try(
    var.remote_objects.app_services[var.settings.private_service_connection.lz_key][var.settings.private_service_connection.resource_key].id,
    var.remote_objects.cosmos_dbs[var.settings.private_service_connection.lz_key][var.settings.private_service_connection.resource_key].cosmos_account,
    var.remote_objects.storage_accounts[var.settings.private_service_connection.lz_key][var.settings.private_service_connection.resource_key].id,
  )
}
