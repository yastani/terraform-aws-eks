#--------------------------------------------------------------
# Common - Prefix
#--------------------------------------------------------------
variable "prefix" {
  type = "string"
  default = "tutorial-aws-eks-"
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
variable "vpc" {
  type = "map"

  default = {
    # primary
    primary.vpc_cidr = "10.0.0.0/16"
  }
}

#--------------------------------------------------------------
# Subnet
#--------------------------------------------------------------
variable "subnet" {
  type = "map"

  default = {
    # cidr

    ## public
    primary.pub_subnet_c_cidr = "10.0.0.0/20"
    primary.pub_subnet_d_cidr = "10.0.16.0/20"

    ## private
    primary.priv_subnet_c_cidr = "10.0.32.0/20"
    primary.priv_subnet_d_cidr = "10.0.48.0/20"

    # subnet

    ## public
    primary.pub_subnet_c_name = "pub-subnet.apne-1c"
    primary.pub_subnet_d_name = "pub-subnet.apne-1d"
    ## private
    primary.priv_subnet_c_name = "priv-subnet.apne-1c"
    primary.priv_subnet_d_name = "priv-subnet.apne-1d"
  }
}

#--------------------------------------------------------------
# Route table
#--------------------------------------------------------------
variable "route_table" {
  type = "map"

  default = {
    ## public
    primary.pub_subnet_route_table_name = "pub-rt.apne-1"

    ## private
    primary.priv_subnet_route_table_name = "priv-rt.apne-1"
  }
}

#--------------------------------------------------------------
# EKS Cluster
#--------------------------------------------------------------
variable "eks_cluster" {
  type = "map"

  default = {
    default.cluster_name = "cluster-apne1"
    default.version = "1.11"
  }
}