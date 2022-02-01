resource "azurerm_storage_object_replication" "obj_repl" {
  source_storage_account_id = var.source_storage_account_id
  destination_storage_account_id = var.destination_storage_account_id

  dynamic "rules" {
    for_each = var.settings.rules

    content {
      source_container_name = rules.value.source_container_name
      destination_container_name = rules.value.destination_container_name
      copy_blobs_created_after = try(rules.value.copy_blobs_created_after, null)
      filter_out_blobs_with_prefix = try(rules.value.filter_out_blobs_with_prefix, null)
    }
  }

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts, null)

    content {
      create = try(timeouts.value.create, null)
      read = try(timeouts.value.read, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}