output "vpc_id" {
  value       = aws_vpc.network.id
  description = "VPC ID by region"
}

output "vpc_cidr_block" {
  value       = aws_vpc.network.cidr_block
  description = "VPC CIDR block by region"
}

output "subnet_private_id" {
  value       = aws_subnet.private[*].id
  description = "Private Subnet ID by region and availability zone"
}

output "subnet_public_id" {
  value       = aws_subnet.public[*].id
  description = "Private Subnet ID by region and availability zone"
}