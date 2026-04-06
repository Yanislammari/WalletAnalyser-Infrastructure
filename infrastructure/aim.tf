resource "azuread_invitation" "guests" {
  for_each = toset(var.aim_users_rg)

  user_email_address = each.key
  redirect_url       = "https://portal.azure.com"
}

resource "azurerm_role_assignment" "rg_access" {
  for_each = azuread_invitation.guests

  scope                = azurerm_resource_group.walletanalyser_rg.id
  role_definition_name = "Contributor"
  principal_id         = each.value.user_id
}
