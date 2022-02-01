resource "azurerm_storage_object_replication" "obj_repl" {
  source_storage_account_id = var.source_storage_account_id
  destination_storage_account_id = var.destination_storage_account_id

  dynamic "rule" {
    for_each = var.settings.rules

    content {
      source_container_name = rule.value.source_container_name
      destination_container_name = rule.value.destination_container_name
      copy_blobs_created_after = try(rule.value.copy_blobs_created_after)
      filter_out_blobs_with_prefix = try(rule.value.filter_out_blobs_with_prefix)
    }
  }

  dynamic "timeout" {
    for_each = var.settings.timeouts

    content {
      create = try(timeouts.value.create)
      read = try(timeouts.value.read)
      update = try(timeouts.value.update)
      delete = try(timeouts.value.delete)
    }
  }
}