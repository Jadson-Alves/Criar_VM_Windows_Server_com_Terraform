provider "azurerm" {
  features {}
}

# Criar Grupo de Recursos
resource "azurerm_resource_group" "server_rg" {
  name     = var.server_rg
  location = var.location
}

# Criar Virtual Network
resource "azurerm_virtual_network" "server_vnet" {
  name                = var.vnet_name
  address_space       = ["${var.vnet_address_space}"]
  location            = var.location
  resource_group_name = azurerm_resource_group.server_rg.name
}

# Criar a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.server_rg.name
  virtual_network_name = azurerm_virtual_network.server_vnet.name
  address_prefixes     = ["${var.subnet_address_space}"]
}

# Criar Network Interface
resource "azurerm_network_interface" "server_nic" {
  name                = var.server_nic
  location            = var.location
  resource_group_name = azurerm_resource_group.server_rg.name

  # Associar endereço IP Privado e Publico a NIC
  ip_configuration {
    name      = var.ip_name
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.server_ip_publico.id
  }

}

# Criar IP Publico
resource "azurerm_public_ip" "server_ip_publico" {
  name                = var.ip_publico_name
  resource_group_name = azurerm_resource_group.server_rg.name
  location            = var.location
  allocation_method = var.publico_ip_allocation

}

# Criar Network Security Group
resource "azurerm_network_security_group" "server_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.server_rg.name
}

# Regra Network Security Group
resource "azurerm_network_security_rule" "nsg_rule" {
  name                        = var.nsg_rule_name
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = var.portas_liberadas
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.server_rg.name
  network_security_group_name = azurerm_network_security_group.server_nsg.name
}

# Associar o NSG a Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_associate_subnet" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.server_nsg.id
}

# Criar a Máquina Virtual
resource "azurerm_windows_virtual_machine" "server_vm" {
  name                = var.server_name
  resource_group_name = azurerm_resource_group.server_rg.name
  location            = var.location
  size                = var.server_size
  admin_username      = var.server_admin
  admin_password      = var.server_password
  network_interface_ids = [
    azurerm_network_interface.server_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.sto_replication
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.server_sku
    version   = "latest"
  }
}