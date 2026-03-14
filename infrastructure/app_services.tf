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
    "FRONTEND_ADDRESS"    = join(",", var.cors_frontend_addresses)
    "DOCKER_ENABLE_CI_CD" = "true"
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
  }

  identity {
    type = "SystemAssigned"
  }
}
