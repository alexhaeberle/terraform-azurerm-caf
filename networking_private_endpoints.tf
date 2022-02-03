module "private_endpoints" {
  source   = "./modules/networking/private_endpoint/"
  for_each = try(var.networking.private_endpoints, {})

  global_settings   = local.global_settings
  client_config     = local.client_config
  settings          = each.value
  resource_groups   = local.combined_objects_resource_groups
  private_dns       = local.combined_objects_private_dns
  subnet_id         = try(module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id, null)

  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.resource_groups[each.value.resource_group_key].tags, null),
    try(local.resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].tags, null),
    {}
  ) : {}
}