# Terraform AWS Network

Este módulo genera una red completa con subred privada/pública, internet gateway y NAT gateway.

## Variables

| Nombre                            | Descripción                                                           |
| --------------------------------- | --------------------------------------------------------------------- |
| vpc_cidr                          | CIDR asociado a la VPC                                                |
| [subnet_public](#subnet_public)   | Objeto que define las subredes públicas y sus zonas de disponibilidad |
| [subnet_private](#subnet_private) | Objeto que define las subredes públicas y sus zonas de disponibilidad |
| commont_tags                      | Map con tags comunes a todos los recursos creados por este módulo     |

### subnet_public

| Nombre  | Descripción                                                                                 |
| ------- | ------------------------------------------------------------------------------------------- |
| cidr    | CIDR principal de la subred pública                                                         |
| subnets | Lista de objetos que definen CIDR (cidr) y zóna de disponibilidad (az) de la subred pública |

### subnet_private

| Nombre  | Descripción                                                                                 |
| ------- | ------------------------------------------------------------------------------------------- |
| cidr    | CIDR principal de la subred privada                                                         |
| subnets | Lista de objetos que definen CIDR (cidr) y zóna de disponibilidad (az) de la subred privada |
