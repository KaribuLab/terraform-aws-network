# ============================================================
## Almacenamiento de estado de Terraform
# ============================================================

terraform {
  provider_versions {
    aws = "5.10.0"
  }
}

# ============================================================
## VPC
# ============================================================

resource "aws_vpc" "network" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
  enable_dns_hostnames = true
  enable_dns_support =  true
}

# ============================================================
## Creación de Internet Gateway
# ============================================================

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.network.id
  tags = merge(
    var.tags,
    {
      Name = "${var.customer} Network ${var.environment}"
    }
  )
}

# ============================================================
## Creación de NAT Gateway 
# ============================================================

resource "aws_eip" "nat_ip" {
  count = length(var.subnet_public.subnets)
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "${var.customer} EIP ${var.subnet_public.subnets[count.index].az} ${var.environment}"
    }
  )
}
resource "aws_nat_gateway" "gateway" {
  count         = length(var.subnet_public.subnets)
  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(var.tags, {
    Name = "NAT Gateway ${var.subnet_public.subnets[count.index].az}"
  })
}

# ============================================================
## Creación de subred publica
# ============================================================

resource "aws_subnet" "public" {
  count                   = length(var.subnet_public.subnets)
  vpc_id                  = aws_vpc.network.id
  availability_zone       = var.subnet_public.subnets[count.index].az
  cidr_block              = var.subnet_public.subnets[count.index].cidr
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name = "Public Subnet ${var.subnet_public.subnets[count.index].az}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id
  route {
    cidr_block = var.subnet_public.cidr
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = merge(
    var.tags,
    {
      Name = "Route Table Public"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.subnet_public.subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ============================================================
## Creación de subred privada
# ============================================================

resource "aws_subnet" "private" {
  count             = length(var.subnet_private.subnets)
  vpc_id            = aws_vpc.network.id
  availability_zone = var.subnet_private.subnets[count.index].az
  cidr_block        = var.subnet_private.subnets[count.index].cidr
  tags = merge(
    var.tags,
    {
      Name = "Private Subnet ${var.subnet_private.subnets[count.index].az}"
    }
  )
}

resource "aws_route_table" "private" {
  count  = length(var.subnet_private.subnets)
  vpc_id = aws_vpc.network.id
  route {
    cidr_block     = var.subnet_private.cidr
    nat_gateway_id = aws_nat_gateway.gateway[count.index].id
  }
  tags = merge(
    var.tags,
    {
      Name = "Route Table Private ${var.subnet_private.subnets[count.index].az}"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.subnet_private.subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}