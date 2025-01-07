variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "k8shardway"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "westus"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "k8shardway"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "k8ssubnet"
}

variable "jumpbox_vm_name" {
  description = "The name of the jumpbox virtual machine"
  type        = string
  default     = "jumpbox"
}

variable "jumpbox_vm_size" {
  description = "The size of the jumpbox VM"
  type        = string
  default     = "Standard_D4ls_v5"
}

variable "server_vm_name" {
  description = "The name of the server virtual machine"
  type        = string
  default     = "server"
}

variable "server_vm_size" {
  description = "The size of the server VM"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "worker_vm_names" {
  description = "The names of the worker virtual machines"
  type        = list(string)
  default     = ["worker-0", "worker-1"]
}

variable "worker_vm_size" {
  description = "The size of the worker VMs"
  type        = string
  default     = "Standard_D4s_v5"
}

variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VMs"
  type        = string
}