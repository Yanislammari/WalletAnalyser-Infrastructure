resource "azurerm_storage_account" "storage" {
  name                     = "walletanalyserstorage"
  resource_group_name      = azurerm_resource_group.walletanalyser_rg.name
  location                 = azurerm_resource_group.walletanalyser_rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    project = "walletanalyser"
    env     = "prod"
  }
}
