resource "azurerm_linux_web_app" "walletanalyser_frontend" {
  name                = "app-walletanalyser-frontend"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location
  service_plan_id     = azurerm_service_plan.walletanalyser_asp.id

  https_only = true

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"

    application_stack {
      docker_registry_url = "https://walletanalyseracr.azurecr.io"
      docker_image_name   = "walletanalyser-frontend:latest"
    }

    container_registry_use_managed_identity = true
  }

  app_settings = {
    "WEBSITES_PORT"       = "80"
    "PORT"                = "80"
    "DOCKER_ENABLE_CI_CD" = "true"

    "WEBSITE_RUN_FROM_PACKAGE"         = "1"
    "APPLICATIONINSIGHTS_ENABLE_AGENT" = "true"
    "APPINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.walletanalyser_appinsights.connection_string

    "VITE_BACKEND_BASE_URL" = var.backend_base_url

    "VITE_GOOGLE_OAUTH_CLIENT_ID" = var.f_google_oauth_client_id
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_linux_web_app" "walletanalyser_backend" {
  name                = "app-walletanalyser-backend"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location
  service_plan_id     = azurerm_service_plan.walletanalyser_asp.id

  https_only = true

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"

    application_stack {
      docker_registry_url = "https://walletanalyseracr.azurecr.io"
      docker_image_name   = "walletanalyser-backend:latest"
    }

    container_registry_use_managed_identity = true
  }

  app_settings = {
    "WEBSITES_PORT"       = "8080"
    "PORT"                = "8080"
    "FRONTEND_ADDRESS" = jsonencode(var.cors_frontend_addresses)
    "DOCKER_ENABLE_CI_CD" = "true"

    "WEBSITE_RUN_FROM_PACKAGE"         = "1"
    "APPLICATIONINSIGHTS_ENABLE_AGENT" = "true"
    "APPINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.walletanalyser_appinsights.connection_string

    "DATABASE_URL" = var.database_url

    "SECRET_KEY"  = var.secret_key
    "TOKEN_SECRET" = var.token_secret

    "GOOGLE_OAUTH_CLIENT_ID" = var.b_google_oauth_client_id

    "MJ_API_KEY"    = var.mj_api_key
    "MJ_API_SECRET" = var.mj_api_secret
    "MJ_SENDER"     = var.mj_sender

    "AZURE_BLOB_STORAGE_CONNECTION_STRING" = var.azure_blob_storage_connection_string
    "AZURE_BLOB_STORAGE_CONTAINER_NAME_TEMPLATES" = var.azure_blob_storage_container_name_templates
    "AZURE_BLOB_STORAGE_CONTAINER_NAME_UPLOADS"  = var.azure_blob_storage_container_name_uploads

    "FRONTEND_URL_PROD" = var.frontend_url_prod

    "MARKETSTACK_API_URL" = var.api_marketstack_url
    "MARKETSTACK_API_KEY" = var.api_marketstack_key
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_linux_web_app" "walletanalyser_admin" {
  name                = "app-walletanalyser-admin"
  resource_group_name = azurerm_resource_group.walletanalyser_rg.name
  location            = azurerm_resource_group.walletanalyser_rg.location
  service_plan_id     = azurerm_service_plan.walletanalyser_asp.id

  https_only = true

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"

    application_stack {
      docker_registry_url = "https://walletanalyseracr.azurecr.io"
      docker_image_name   = "walletanalyser-admin:latest"
    }

    container_registry_use_managed_identity = true
  }

  app_settings = {
    "WEBSITES_PORT"       = "80"
    "PORT"                = "80"
    "DOCKER_ENABLE_CI_CD" = "true"

    "WEBSITE_RUN_FROM_PACKAGE"         = "1"
    "APPLICATIONINSIGHTS_ENABLE_AGENT" = "true"

    "APPINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.walletanalyser_appinsights.connection_string
  }

  identity {
    type = "SystemAssigned"
  }
}
