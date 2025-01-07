resource "azurerm_public_ip" "jumpbox_public_ip" {
  name                = "${var.jumpbox_vm_name}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "${var.jumpbox_vm_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                  = var.jumpbox_vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]
  size                  = var.jumpbox_vm_size

  os_disk {
    name              = "${var.jumpbox_vm_name}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  custom_data = filebase64("${path.module}/cloud-init/jumpbox.yaml")

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_public_ip" "server_public_ip" {
  name                = "${var.server_vm_name}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "server_nic" {
  name                = "${var.server_vm_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.server_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "server" {
  name                  = var.server_vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.server_nic.id]
  size                  = var.server_vm_size

  os_disk {
    name              = "${var.server_vm_name}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_public_ip" "worker_public_ips" {
  count               = length(var.worker_vm_names)
  name                = "${var.worker_vm_names[count.index]}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "worker_nics" {
  count               = length(var.worker_vm_names)
  name                = "${var.worker_vm_names[count.index]}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.worker_public_ips[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "workers" {
  count                 = length(var.worker_vm_names)
  name                  = var.worker_vm_names[count.index]
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.worker_nics[count.index].id]
  size                  = var.worker_vm_size

  os_disk {
    name              = "${var.worker_vm_names[count.index]}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  lifecycle {
    prevent_destroy = false
  }
}