#################################################
# 1️⃣ Inviter les utilisateurs externes
#################################################
resource "azuread_invitation" "guests" {
  for_each = toset(var.aim_users_rg)

  user_email_address = each.key
  redirect_url       = "https://portal.azure.com"
}

#################################################
# 2️⃣ Donner le rôle Contributor sur le Resource Group
#################################################
resource "azurerm_role_assignment" "rg_access" {
  for_each = azuread_invitation.guests

  scope                = azurerm_resource_group.walletanalyser_rg.id
  role_definition_name = "Contributor"
  principal_id         = each.value.user_id
}

#################################################
# 3️⃣ Récupérer le Service Principal Terraform
#################################################
data "azuread_service_principal" "terraform_sp" {
  client_id = var.client_id
}

#################################################
# 4️⃣ Activer le rôle Guest Inviter (si pas déjà actif)
#################################################
resource "azuread_directory_role" "guest_inviter" {
  display_name = "Guest Inviter"
}

#################################################
# 5️⃣ Assigner le rôle Guest Inviter au SP
#################################################
resource "azuread_directory_role_assignment" "sp_guest_inviter" {
  principal_object_id = data.azuread_service_principal.terraform_sp.object_id
  role_id             = azuread_directory_role.guest_inviter.object_id
}
