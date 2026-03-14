resource "azurerm_log_analytics_workspace" "walletanalyser_logs" {
  name                = "walletanalyser-log"
  location            = azurerm_resource_group.walletanalyser_rg.location
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
