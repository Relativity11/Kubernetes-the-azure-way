output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "jumpbox_ip" {
  value = azurerm_network_interface.jumpbox_nic.private_ip_address
}

output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox_public_ip.ip_address
}

output "server_ip" {
  value = azurerm_network_interface.server_nic.private_ip_address
}

output "server_public_ip" {
  value = azurerm_public_ip.server_public_ip.ip_address
}

output "worker_ips" {
  value = [for nic in azurerm_network_interface.worker_nics : nic.private_ip_address]
}

output "worker_public_ips" {
  value = [for ip in azurerm_public_ip.worker_public_ips : ip.ip_address]
}