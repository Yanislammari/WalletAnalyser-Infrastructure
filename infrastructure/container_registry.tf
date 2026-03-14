resource "azurerm_container_registry" "walletanalyser_acr" {
  name                = "walletanalyseracr"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "frontend_acr_pull" {
  scope                = azurerm_container_registry.walletanalyser_acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.walletanalyser_frontend.identity[0].principal_id
}

resource "azurerm_role_assignment" "backend_acr_pull" {
  scope                = azurerm_container_registry.walletanalyser_acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.walletanalyser_backend.identity[0].principal_id
}

resource "azurerm_role_assignment" "admin_acr_pull" {
  scope                = azurerm_container_registry.walletanalyser_acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.walletanalyser_admin.identity[0].principal_id
}
