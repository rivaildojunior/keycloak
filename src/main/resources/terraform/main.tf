terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 4.0"
    }
  }
}

provider "keycloak" {
  client_id     = "admin-cli"
  username      = "admin"
  password      = "admin"
  url           = "http://localhost:8080"
  initial_login = true
}

resource "keycloak_realm" "commerce" {
  realm        = "commerce"
  enabled      = true
  display_name = "Commerce"
}

resource "keycloak_openid_client" "api_commerce" {
  realm_id              = keycloak_realm.commerce.id
  client_id             = "api-commerce"
  name                  = "API Sales Commerce"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  service_accounts_enabled = true
  direct_access_grants_enabled = true

  valid_redirect_uris = ["http://localhost:8080/*"]
}

resource "keycloak_user" "seller" {
  realm_id   = keycloak_realm.commerce.id
  username   = "seller"
  email      = "seller@gmail.com"
  first_name = "Seller"
  last_name  = "Test"
  enabled    = true
  initial_password {
    value     = "1234"
    temporary = false
  }
}

resource "keycloak_role" "role_seller" {
  realm_id = keycloak_realm.commerce.id
  name     = "ROLE_SELLER"
}

resource "keycloak_user_roles" "assign_role_seller" {
  realm_id = keycloak_realm.commerce.id
  user_id  = keycloak_user.seller.id
  role_ids = [keycloak_role.role_seller.id]
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "user_roles_mapper" {
  realm_id        = keycloak_realm.commerce.id
  client_id       = keycloak_openid_client.api_commerce.id
  name            = "user-roles"
  claim_name      = "realm_access.roles"
  claim_value_type = "String"
  multivalued     = true
  add_to_access_token = true
  add_to_id_token = true
}
