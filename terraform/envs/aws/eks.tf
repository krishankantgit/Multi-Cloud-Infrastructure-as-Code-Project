variable "eks_cluster_name" { type = string, default = "mc-eks" }

# Example: derive subnets via data sources or add as inputs
data "aws_subnets" "private" {
  filter {
    name   = "tag:Network"
    values = ["private"]
  }
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = var.eks_cluster_name
  region             = var.region
  vpc_id             = module.network.vpc_id
  private_subnet_ids = data.aws_subnets.private.ids
}


