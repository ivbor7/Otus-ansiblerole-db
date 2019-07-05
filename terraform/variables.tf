variable project {
  description = "Project ID"
  default = "infra-244305"
}

variable region {
  description = "Region"
# default value
  default = "us-central1"
}

variable public_key_path {
# variable description
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/appuser.pub"
}

variable disk_image {
  description = "Disk image"
  default = "reddit-base"
}

variable private_key_path {
  description = "Path to ssh private key"
  default = "~/.ssh/appuser"
}
