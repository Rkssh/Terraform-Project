# # Create a resource group
# resource "azurerm_resource_group" "learning" {
#   name     = "learning"
#   location = "West Europe"
# }

# resource "azurerm_virtual_network" "avn-1" {
#   name                = "avn-1"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.learning.location
#   resource_group_name = azurerm_resource_group.learning.name
# }

# resource "azurerm_subnet" "subnet-1" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.learning.name
#   virtual_network_name = azurerm_virtual_network.avn-1.name
#   address_prefixes     = ["10.0.2.0/24"]
# }


# resource "azurerm_network_interface" "nic-1" {
#   name                = "nic-1"
#   location            = azurerm_resource_group.learning.location
#   resource_group_name = azurerm_resource_group.learning.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet-1.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "linux-vm" {
#   name                = "linux-vm"
#   resource_group_name = azurerm_resource_group.learning.name
#   location            = azurerm_resource_group.learning.location
#   size                = "Standard_F2"
#   admin_username      = "adminuser"
#   admin_password      = "Dipu$ingh123"
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.nic-1.id,
#   ]


#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# }