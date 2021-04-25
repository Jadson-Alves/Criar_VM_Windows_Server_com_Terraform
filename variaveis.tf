variable "server_rg" {
  description = "Nome do Grupo de Recursos"
  default     = "RG-Servidores"
}

variable "location" {
  description = "Localização que os recursos serão criados"
  default     = "EastUS"
}

variable "vnet_name" {
  description = "Nome da Virtual Network"
  default     = "vnet-servidores"

}

variable "vnet_address_space" {
  description = "Endereço IP da Virtual Network"
  default     = "10.0.0.0/16"

}

variable "subnet_name" {
  description = "Nome da Subnet"
  default     = "subnet-servidores"
}

variable "subnet_address_space" {
  description = "Endereço IP da subnet"
  default     = "10.0.2.0/24"
}

variable "server_nic" {
  description = "Nome da network interface"
  default     = "VM-001-nic"
}

variable "private_ip_allocation" {
  description = "Tipo de alocação do endereço IP Privado"
  default     = "Dynamic"
}

variable "ip_name" {
  description = "Nome do Endereço IP Privado"
  default     = "VM-001-ip"
}

variable "ip_publico_name" {
  description = "Criar IP Publico"
  default     = "IP-Publico-VM-001"
}

variable "publico_ip_allocation" {
  description = "Tipo de alocação do endereço IP Publico"
  default     = "Static"
}

variable "nsg_name" {
  description = "Nome do Network Security Group"
  default     = "nsg-servidores"
}

variable "nsg_rule_name" {
  description = "Nome da regra Network Security Grupo"
  default     = "Allow_Porta_HTTP_HTTPS_RDP"
}

variable "portas_liberadas" {
  description = "Portas liberadas na regra do NSG"
  type        = list(string)
  default     = ["3389", "443", "80"]
}

variable "server_name" {
  description = "Nome da Máquina virtual"
  default     = "VM-001"
}

variable "server_size" {
  description = "Tamanho da máquina virtual"
  default     = "Standard_F2"
}

variable "server_admin" {
  description = "Usuário Administrador da VM"
  default     = "adm.jadson"
}

variable "server_password" {
  description = "Senha do usuário Administrador da VM"
  default     = "P@$$w0rd1234!"
}

variable "sto_replication" {
  description = "Replicação do Storage Account"
  default     = "Standard_LRS"
}

variable "server_sku" {
  description = "Versão do Sistema operacional"
  default     = "2016-Datacenter"
}

