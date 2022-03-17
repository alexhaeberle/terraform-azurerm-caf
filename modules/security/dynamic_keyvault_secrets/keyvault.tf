module "secret" {
  source = "./secret"
  /* for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == null
  } */

  name  = var.settings.secret_name
  /* value = can(each.key.output_key) && (can(each.key.resource_key) || can(each.key.attribute_key)) ? lookup(lookup(var.objects[each.key.output_key], try(each.key.resource_key, ""), var.objects[each.key.output_key]), each.key.attribute_key, null) : each.key.value */
  value = var.settings.value
  # for future generations: double lookup because each.value.resource_key is optional
  keyvault_id = var.keyvault.id
}

module "secret_value" {
  source = "./secret"
  /* for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) != null && try(value.value, null) != ""
  } */

  name        = var.settings.secret_name
  value       = var.settings.value
  keyvault_id = var.keyvault.id
}

module "secret_immutable" {
  source = "./secret_immutable"
  /* for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == ""
  } */

  name  = var.settings.secret_name
  /* value = can(each.key.output_key) && (can(each.key.resource_key) || can(each.key.attribute_key)) ? lookup(lookup(var.objects[each.key.output_key], try(each.key.resource_key, ""), var.objects[each.key.output_key]), each.key.attribute_key, null) : each.key.value */
  value = var.settings.value
  # for future generations: double lookup because each.value.resource_key is optional
  keyvault_id = var.keyvault.id
}
