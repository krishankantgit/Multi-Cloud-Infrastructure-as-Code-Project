variable "name_prefix" { type = string }
variable "cidr_block"  { type = string }

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = { Name = "${var.name_prefix}-vpc" }
}

output "vpc_id" { value = aws_vpc.this.id }


