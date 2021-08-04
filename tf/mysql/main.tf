terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.70.0"
    }
  }
}

variable "region" {
	default = ""
	description = "Region to use"
}

provider "azurerm" {
	features {}
}

resource "azurerm_resource_group" "main" {
  name     = "main"
  location = "North Europe"
}


resource "azurerm_mysql_server" "test" {
  name                = "test-ix259len3l"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  administrator_login          = "mysqladmin"
  administrator_login_password = "1$%nxc07;UHQ"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}


resource "azurerm_mysql_database" "test" {
  name                = "testdb"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_server.test.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
/**/

resource "azurerm_mysql_firewall_rule" "test" {
  name                = "from_office"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_server.test.name
  start_ip_address    = "81.95.21.26"
  end_ip_address      = "81.95.21.26"
}

