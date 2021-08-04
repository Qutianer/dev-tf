terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.70.0"
    }
  }
}


provider "azurerm" {
	features {}
}

locals {
  sitename = join("",["mywebsite-",random_string.sitename.result])
}

resource "azurerm_resource_group" "main" {
  name     = "main"
  location = "North Europe"
}

resource "azurerm_app_service_plan" "main" {
  name                = "main-appserviceplan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "main" {
  name                = local.sitename
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

app_settings = {
    "SOME_KEY" = "some-value"
  }
  source_control {
    repo_url = var.githubsource 
    branch = "master"
    manual_integration = true

  }

}

output "name" {
value = azurerm_app_service.main.default_site_hostname
}
