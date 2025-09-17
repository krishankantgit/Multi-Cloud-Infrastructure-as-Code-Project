variable "name_prefix" { type = string }
variable "cidr_block"  { type = string }
variable "num_private_subnets" { type = number, default = 2 }

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = { Name = "${var.name_prefix}-vpc" }
}

data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.num_private_subnets)
}

resource "aws_subnet" "private" {
  count             = var.num_private_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index)
  availability_zone = local.azs[count.index]
  tags = {
    Name    = "${var.name_prefix}-private-${count.index}"
    Network = "private"
  }
}

output "vpc_id" { value = aws_vpc.this.id }
output "private_subnet_ids" { value = [for s in aws_subnet.private : s.id] }


