output "vm_ip_publico" {
  value = azurerm_public_ip.server_ip_publico
}


output "vm_ip_private" {
  value = azurerm_windows_virtual_machine.server_vm.private_ip_address
}


