resource "azurerm_redis_cache" "main" {
  name                = "walletanalyser-redis"
  location            = azurerm_resource_group.walletanalyser_rg.location
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name

  capacity            = 0
  family              = "C"
  sku_name            = "Basic"

  minimum_tls_version = "1.2"

  redis_configuration {}
}
