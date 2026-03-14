resource "azurerm_service_plan" "walletanalyser_asp" {
  name                = "walletanalyser-asp"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location

  os_type  = "Linux"
  sku_name = "B1"
}
