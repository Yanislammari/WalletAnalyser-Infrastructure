resource "azurerm_resource_group" "walletanalyser_rg" {
  name     = local.rg_name
  location = local.location
}
