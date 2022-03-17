module "secret" {
  source = "./secret"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == null
  }

  name  = each.key.secret_name
  value = can(each.key.output_key) && (can(each.key.resource_key) || can(each.key.attribute_key)) ? lookup(lookup(var.objects[each.key.output_key], try(each.key.resource_key, ""), var.objects[each.key.output_key]), each.key.attribute_key, null) : each.key.value
  # for future generations: double lookup because each.value.resource_key is optional
  keyvault_id = var.keyvault.id
}

module "secret_value" {
  source = "./secret"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) != null && try(value.value, null) != ""
  }

  name        = each.key.secret_name
  value       = each.key.value
  keyvault_id = var.keyvault.id
}

module "secret_immutable" {
  source = "./secret_immutable"
  for_each = {
    for key, value in var.settings : key => value
    if try(value.value, null) == ""
  }

  name  = each.key.secret_name
  value = can(each.key.output_key) && (can(each.key.resource_key) || can(each.key.attribute_key)) ? lookup(lookup(var.objects[each.key.output_key], try(each.key.resource_key, ""), var.objects[each.key.output_key]), each.key.attribute_key, null) : each.key.value
  # for future generations: double lookup because each.value.resource_key is optional
  keyvault_id = var.keyvault.id
}
