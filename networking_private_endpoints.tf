module "private_endpoints" {
  source   = "./modules/networking/private_endpoint/"
  for_each = try(var.networking.private_endpoints, {})
}