
# When called from the CAF module it can only be used to set secret values
# For that reason, object must not be set.
# This is only used here for examples to run
# the normal recommendation for dynamic keyvault secrets is to call it from a landingzone
module "dynamic_keyvault_secrets" {
  source     = "./modules/security/dynamic_keyvault_secrets"
  depends_on = [module.keyvaults]
  /* for_each = {
    for keyvault_key, secrets in try(var.security.dynamic_keyvault_secrets, {}) : keyvault_key => {
      for key, value in secrets : key => value
      if try(value.value, null) != null
    }
  } */

  for_each = {
    for key, value in try(var.security.dynamic_keyvault_secrets, {}) : key => value
  }

  settings = each.key
  keyvault = local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.kv_key]
}

output "dynamic_keyvault_secrets" {
  value = module.dynamic_keyvault_secrets
}