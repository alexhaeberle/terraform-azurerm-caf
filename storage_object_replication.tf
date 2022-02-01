
/* resource "time_sleep" "delay" {
  seconds = "10"
} */

module "storage_object_replication" {
  source = "./modules/storage_account/object_replication"
  for_each = var.object_replication

  source_storage_account_id       = try(
    # local.combined_objects_storage_accounts[each.value.storage_accounts.lz_key][each.value.storage_accounts.key].name,
    local.combined_objects_storage_accounts[each.value.storage_accounts.lz_key][each.value.source_storage_account_key].id,
    # local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_accounts.key].name,
    local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.source_storage_account_key].id
  )
  destination_storage_account_id  = try(
    # local.combined_objects_storage_accounts[each.value.storage_accounts.lz_key][each.value.storage_accounts.key].name,
    local.combined_objects_storage_accounts[each.value.storage_accounts.lz_key][each.value.destination_storage_account_key].id,
    # local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_accounts.key].name,
    local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.destination_storage_account_key].id
  )
  settings                        = each.value
}

output "storage_object_replication" {
  value = module.storage_object_replication
}