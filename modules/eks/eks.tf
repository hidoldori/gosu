module "eks" {
  # source  = "terraform-aws-modules/eks/aws"
  # version = "19.12.0"
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"


  cluster_name    = "gosu-eks-an2-prod-app"
  cluster_version = "1.30"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.private-subnet-ids

  //vpc_id     = "vpc-0645cf53333ddb9f5" // cicd 환경의 vpc
  //subnet_ids = var.subnet_ids // variables.tf 참조할 것.

  // 직접 작업하고자 하는 경우
  //vpc_id     = "vpc-0645cf53333ddb9f5"
  //subnet_ids = var.subnet_ids #var 파일 list type

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  cluster_addons = {
    /*
    coredns = {
      addon_version = "v1.9.3-eksbuild.2"
    }
    kube-proxy = {
      addon_version = "v1.26.2-eksbuild.1"
    }
    vpc-cni = {
      addon_version = "v1.12.6-eksbuild.1"
    }
      */
      coredns = {}
      kube-proxy = {}
      vpc-cni = {}
  }

  cluster_enabled_log_types              = ["audit", "authenticator", "api", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = 1

  ## add rule for cluster security group
  cluster_security_group_additional_rules = {
    ingress_gitlab = {
      description = "http from gitlab"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["100.69.131.0/24"]
    }
  }


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type                               = "AL2_x86_64"
    subnet_ids                             = data.terraform_remote_state.network.outputs.private-subnet-ids
    //subnet_ids = var.subnet_ids // variables.tf 참조할 것.

    // 직접 참조하고자 하는 경우 
    // subnet_ids                             = var.subnet_ids #var 파일 list type
    disk_size                              = 20
    instance_types                         = ["t3.small"]
    update_launch_template_default_version = true
  }

  eks_managed_node_groups = {
    management-node = {
      name            = "management-node-app"
      use_name_prefix = false
      ami_type        = "AL2_x86_64"
      platform        = "linux"

      labels = {
        System = "management"
      }

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }


}
