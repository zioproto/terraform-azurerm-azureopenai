locals {
  custom_data = <<CUSTOM_DATA
#!/bin/bash
echo "Execute your super awesome commands here!"
sudo sed -i "s/#Port 22/Port 2222/" /etc/ssh/sshd_config
sudo systemctl restart ssh
CUSTOM_DATA
}


resource "azurerm_network_security_group" "nsg" {
  name                = "ssh_nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2222"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "main" {
  name                = "vm-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = lookup(module.vnet.vnet_subnets_name_id, "subnet0")
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "example-public-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
}


resource "azurerm_virtual_machine" "main" {
  name                  = "myubuntuvm"
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "22.04.202301050"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    custom_data    = base64encode(local.custom_data)
  }


  os_profile_linux_config {
    disable_password_authentication = false

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpux1Um/iKn8irWebhYGcuAvQInAG2sbI+Ac853XK1TdQyHuMPVeFs4JZREeSXIFFoY3yqrmSJTfeAkIvS1+d0EXwgC/0Nc6qCgFt4JwRoqXwfbsPAzZLOuiXvj+ssHp2aFxA8r+N3GuG5zrzxiC6w5ClwJMtXnap2t3cq/9V4nuKxCFIBjnT8dvoNMOOA3JZ0Cun+VaQrnocee9qyDl1AwkUkT01qSe6HovZUUE0vR1nVSrBFayx0TAK+fjPPfjcm0U68krM4N2puN7YFydgcTumSZL+/8Mr2P0zkB4Axc/BaA12dmmu0bW0IK4L7i6g648cmoNbM0/rHokfQINUnw5Gx77pS32udVGFCSfPcvILk9ePrXEqAofFV0AXGa9Bs1GmpRsNM0mTzmXHjdVr6MostJhvfUoR4pKKKQKVW5pXjvimE5/IdGQ6pCBjhQHyvOhOBpXJPwBHwvi6c97a0kYzM/ETeYUa4btNKdxVzEzKP9b+VxR04bgk46brx6SU= saverioproto@Saverios-MacBook-Pro.local"
    }
  }

  tags = {
    environment = "staging"
  }
}