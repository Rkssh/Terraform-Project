resource "azurerm_resource_group" "variprojects" {
  name     = "variprojects"
  location = "West Europe"
}

resource "azurerm_virtual_network" "azurevmn" {
  name                = "azurevn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.variprojects.location
  resource_group_name = azurerm_resource_group.variprojects.name
}

resource "azurerm_subnet" "azuresub" {
  name                 = "azuresub"
  resource_group_name  = azurerm_resource_group.variprojects.name
  virtual_network_name = azurerm_virtual_network.azurevmn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.variprojects.name
  location            = azurerm_resource_group.variprojects.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "azurenic" {
  name                = "azurenic"
  location            = azurerm_resource_group.variprojects.location
  resource_group_name = azurerm_resource_group.variprojects.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azuresub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "azurevm" {
  name                = "azurevm"
  resource_group_name = azurerm_resource_group.variprojects.name
  location            = azurerm_resource_group.variprojects.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Dipu$ingh123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.azurenic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}