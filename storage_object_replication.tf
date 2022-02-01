
/* resource "time_sleep" "delay" {
  seconds = "10"
} */

module "storage_object_replication" {
  source = "./modules/storage_account/object_replication"
  for_each = var.object_replication

  source_storage_account_id       = each.value.source_storage_account_id
  destination_storage_account_id  = each.value.destination_storage_account_id
  settings                        = each.value
}

output "storage_object_replication" {
  value = module.storage_object_replication
}