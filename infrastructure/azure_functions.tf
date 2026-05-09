resource "azurerm_linux_function_app" "walletanalyser_functions" {
  name                = "walletanalyser-functions"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location

  service_plan_id            = azurerm_service_plan.walletanalyser_asp.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key

  https_only = true

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME              = "node"
    WEBSITE_RUN_FROM_PACKAGE              = "1"
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.walletanalyser_appinsights.connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.walletanalyser_appinsights.instrumentation_key

    AZURE_BLOB_STORAGE_CONNECTION_STRING        = var.azure_blob_storage_connection_string
    AZURE_BLOB_STORAGE_CONTAINER_NAME_TEMPLATES = var.azure_blob_storage_container_name_templates
    AZURE_BLOB_STORAGE_CONTAINER_NAME_UPLOADS   = var.azure_blob_storage_container_name_uploads

    DATABASE_URL = var.database_url
  }

  site_config {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"

    application_insights_connection_string = azurerm_application_insights.walletanalyser_appinsights.connection_string
    application_insights_key               = azurerm_application_insights.walletanalyser_appinsights.instrumentation_key

    application_stack {
      node_version = "20"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    project = "walletanalyser"
    env     = "prod"
  }
}
