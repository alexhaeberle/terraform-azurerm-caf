module "secret" {
  source = "./secret"
  /* for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == null
  } */

  name  = var.settings.secret_name
  value = can(var.settings.output_key) && (can(var.settings.resource_key) || can(var.settings.attribute_key)) ? lookup(lookup(var.objects[each.value.output_key], try(each.value.resource_key, ""), var.objects[each.value.output_key]), each.value.attribute_key, null) : var.settings.value
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
  value = can(var.settings.output_key) && (can(var.settings.resource_key) || can(var.settings.attribute_key)) ? lookup(lookup(var.objects[each.value.output_key], try(each.value.resource_key, ""), var.objects[each.value.output_key]), each.value.attribute_key, null) : var.settings.value
  # for future generations: double lookup because each.value.resource_key is optional
  keyvault_id = var.keyvault.id
}
