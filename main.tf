terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox.infratrick.com.br:8006/api2/json"
  pm_debug = true
}

resource "proxmox_lxc" "basic" {
  target_node  = "it-virt-01"
  hostname     = "lxc-teste"
  ostemplate   = "local:vztmpl/ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
  password     = "BasicLXCContainer"
  unprivileged = true
  start        = true
  memory       = 2048
  cpulimit     = 2
  cpuunits     = 2048
  vmid         = 199

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "2G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.68.45/24"
  }
}