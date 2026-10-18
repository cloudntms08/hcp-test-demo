resource "azurerm_resource_group" "rg" {
  name     = "ayushi-ntmstf-rg"
  location = "westus"
  tags = {
    env   = "dev"
    owner = "ayushintms"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "ayushi-vnet"
  resource_group_name = azurerm_resource_group.rg.name #reference
  location            = azurerm_resource_group.rg.location #reference
  address_space       = ["10.1.0.0/16"]
  tags = {
    env   = "dev"
    owner = "ayushi"
  }

}

resource "azurerm_subnet" "snet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "ayushi-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags = {
    env   = "dev"
    owner = "ayushi"
  }
}

resource "azurerm_network_security_rule" "http" {
  name                        = "allow-http"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rdp" {
  name                        = "allow-rdp"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


