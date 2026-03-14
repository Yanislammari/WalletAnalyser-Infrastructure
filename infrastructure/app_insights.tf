resource "azurerm_application_insights" "walletanalyser_appinsights" {
  name                = "walletanalyser-appinsights"
  location            = azurerm_resource_group.walletanalyser_rg.location
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  application_type    = "web"
}
