/*
resource "random_string" "password" {
  length           = 16
  special          = true
#  override_special = "/@£$"
}
*/

resource "random_string" "sitename" {
  length           = 8
  special	= false
  upper		= false
}

resource "random_string" "dbname" {
  length           = 8
  special	= false
  upper		= false
}

resource "random_string" "dbpassword" {
  length           = 16
  special          = true
#  override_special = "/@£$"
}

variable "githubsource" {
	default = "https://github.com/Qutianer/dev-webapp"
}
