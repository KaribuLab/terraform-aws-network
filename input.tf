# ============================================================
## Variables para VPC
# ============================================================

variable "vpc_cidr" {
  type    = string
  default = "value"
}

# ============================================================
## Variables para subred publica
# ============================================================

# Public Subnet
# ------------------------------------------------------------
variable "subnet_public" {
  type = object({
    cidr=string
    subnets=list(object({
    az     = string
    cidr = string
  }))
  })
}

# ============================================================
## Variables para subred privada
# ============================================================

# Private Subnet
# ------------------------------------------------------------

variable "subnet_private" {
  type = object({
    cidr=string
    subnets=list(object({
    az     = string
    cidr = string
  }))
  })
}

variable "customer" {
  type        = string
  default     = ""
}

variable "environment" {
  type        = string
  default     = ""
}

# ============================================================
## Variables para Tags
# ============================================================

variable "tags" {
  type = map(any)
}
