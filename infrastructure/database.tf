resource "azurerm_postgresql_flexible_server" "walletanalyser_db" {
  name                   = "walletanalyser-database"
  resource_group_name    = azurerm_resource_group.walletanalyser_rg.name
  location               = "northeurope"
  version                = "15"
  administrator_login    = var.postgresql_admin_username
  administrator_password = var.postgresql_admin_password

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  zone = "3"

  maintenance_window {
    day_of_week  = 0
    start_hour   = 0
    start_minute = 0
  }

  depends_on = [azurerm_resource_group.walletanalyser_rg]
}

resource "azurerm_postgresql_flexible_server_database" "walletanalyser_database" {
  name      = "walletanalyserdb"
  server_id = azurerm_postgresql_flexible_server.walletanalyser_db.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_postgresql_flexible_server.walletanalyser_db.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_specific_ips" {
  for_each         = toset(var.allowed_ips)
  name             = "AllowIP-${replace(each.value, ".", "-")}"
  server_id        = azurerm_postgresql_flexible_server.walletanalyser_db.id
  start_ip_address = each.value
  end_ip_address   = each.value
}
