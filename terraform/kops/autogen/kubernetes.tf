locals {
  cluster_name                 = "k8s.11be.org"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-us-east-2a-masters-k8s-11be-org.id]
  master_security_group_ids    = [aws_security_group.masters-k8s-11be-org.id]
  masters_role_arn             = aws_iam_role.masters-k8s-11be-org.arn
  masters_role_name            = aws_iam_role.masters-k8s-11be-org.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-k8s-11be-org.id]
  node_security_group_ids      = [aws_security_group.nodes-k8s-11be-org.id]
  node_subnet_ids              = [aws_subnet.us-east-2a-k8s-11be-org.id]
  nodes_role_arn               = aws_iam_role.nodes-k8s-11be-org.arn
  nodes_role_name              = aws_iam_role.nodes-k8s-11be-org.name
  region                       = "us-east-2"
  route_table_public_id        = aws_route_table.k8s-11be-org.id
  subnet_us-east-2a_id         = aws_subnet.us-east-2a-k8s-11be-org.id
  vpc_cidr_block               = aws_vpc.k8s-11be-org.cidr_block
  vpc_id                       = aws_vpc.k8s-11be-org.id
}

output "cluster_name" {
  value = "k8s.11be.org"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-us-east-2a-masters-k8s-11be-org.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-k8s-11be-org.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-k8s-11be-org.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-k8s-11be-org.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-k8s-11be-org.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-k8s-11be-org.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-2a-k8s-11be-org.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-k8s-11be-org.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-k8s-11be-org.name
}

output "region" {
  value = "us-east-2"
}

output "route_table_public_id" {
  value = aws_route_table.k8s-11be-org.id
}

output "subnet_us-east-2a_id" {
  value = aws_subnet.us-east-2a-k8s-11be-org.id
}

output "vpc_cidr_block" {
  value = aws_vpc.k8s-11be-org.cidr_block
}

output "vpc_id" {
  value = aws_vpc.k8s-11be-org.id
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_autoscaling_group" "master-us-east-2a-masters-k8s-11be-org" {
  name                 = "master-us-east-2a.masters.k8s.11be.org"
  launch_configuration = aws_launch_configuration.master-us-east-2a-masters-k8s-11be-org.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.us-east-2a-k8s-11be-org.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "k8s.11be.org"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "master-us-east-2a.masters.k8s.11be.org"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-2a"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-us-east-2a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-k8s-11be-org" {
  name                 = "nodes.k8s.11be.org"
  launch_configuration = aws_launch_configuration.nodes-k8s-11be-org.id
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.us-east-2a-k8s-11be-org.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "k8s.11be.org"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "nodes.k8s.11be.org"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-k8s-11be-org" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "a.etcd-events.k8s.11be.org"
    "k8s.io/etcd/events"                 = "a/a"
    "k8s.io/role/master"                 = "1"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-k8s-11be-org" {
  availability_zone = "us-east-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "a.etcd-main.k8s.11be.org"
    "k8s.io/etcd/main"                   = "a/a"
    "k8s.io/role/master"                 = "1"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-k8s-11be-org" {
  name = "masters.k8s.11be.org"
  role = aws_iam_role.masters-k8s-11be-org.name
}

resource "aws_iam_instance_profile" "nodes-k8s-11be-org" {
  name = "nodes.k8s.11be.org"
  role = aws_iam_role.nodes-k8s-11be-org.name
}

resource "aws_iam_role" "masters-k8s-11be-org" {
  name               = "masters.k8s.11be.org"
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.k8s.11be.org_policy")
}

resource "aws_iam_role" "nodes-k8s-11be-org" {
  name               = "nodes.k8s.11be.org"
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.k8s.11be.org_policy")
}

resource "aws_iam_role_policy" "masters-k8s-11be-org" {
  name   = "masters.k8s.11be.org"
  role   = aws_iam_role.masters-k8s-11be-org.name
  policy = file("${path.module}/data/aws_iam_role_policy_masters.k8s.11be.org_policy")
}

resource "aws_iam_role_policy" "nodes-k8s-11be-org" {
  name   = "nodes.k8s.11be.org"
  role   = aws_iam_role.nodes-k8s-11be-org.name
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.k8s.11be.org_policy")
}

resource "aws_internet_gateway" "k8s-11be-org" {
  vpc_id = aws_vpc.k8s-11be-org.id

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-k8s-11be-org-2af1cda0b87eb83fcbdf3cea313a04aa" {
  key_name   = "kubernetes.k8s.11be.org-2a:f1:cd:a0:b8:7e:b8:3f:cb:df:3c:ea:31:3a:04:aa"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.k8s.11be.org-2af1cda0b87eb83fcbdf3cea313a04aa_public_key")
}

resource "aws_launch_configuration" "master-us-east-2a-masters-k8s-11be-org" {
  name_prefix                 = "master-us-east-2a.masters.k8s.11be.org-"
  image_id                    = "ami-09d3627b4a09f6c4c"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.kubernetes-k8s-11be-org-2af1cda0b87eb83fcbdf3cea313a04aa.id
  iam_instance_profile        = aws_iam_instance_profile.masters-k8s-11be-org.id
  security_groups             = [aws_security_group.masters-k8s-11be-org.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/data/aws_launch_configuration_master-us-east-2a.masters.k8s.11be.org_user_data")

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-k8s-11be-org" {
  name_prefix                 = "nodes.k8s.11be.org-"
  image_id                    = "ami-09d3627b4a09f6c4c"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.kubernetes-k8s-11be-org-2af1cda0b87eb83fcbdf3cea313a04aa.id
  iam_instance_profile        = aws_iam_instance_profile.nodes-k8s-11be-org.id
  security_groups             = [aws_security_group.nodes-k8s-11be-org.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/data/aws_launch_configuration_nodes.k8s.11be.org_user_data")

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "all" {
  route_table_id         = aws_route_table.k8s-11be-org.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s-11be-org.id
}

resource "aws_route_table" "k8s-11be-org" {
  vpc_id = aws_vpc.k8s-11be-org.id

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
    "kubernetes.io/kops/role"            = "public"
  }
}

resource "aws_route_table_association" "us-east-2a-k8s-11be-org" {
  subnet_id      = aws_subnet.us-east-2a-k8s-11be-org.id
  route_table_id = aws_route_table.k8s-11be-org.id
}

resource "aws_security_group" "masters-k8s-11be-org" {
  name        = "masters.k8s.11be.org"
  vpc_id      = aws_vpc.k8s-11be-org.id
  description = "Security group for masters"

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "masters.k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_security_group" "nodes-k8s-11be-org" {
  name        = "nodes.k8s.11be.org"
  vpc_id      = aws_vpc.k8s-11be-org.id
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "nodes.k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-k8s-11be-org.id
  source_security_group_id = aws_security_group.masters-k8s-11be-org.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-k8s-11be-org.id
  source_security_group_id = aws_security_group.masters-k8s-11be-org.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-k8s-11be-org.id
  source_security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-k8s-11be-org.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = aws_security_group.masters-k8s-11be-org.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-k8s-11be-org.id
  source_security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-k8s-11be-org.id
  source_security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-k8s-11be-org.id
  source_security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-k8s-11be-org.id
  source_security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-k8s-11be-org.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.nodes-k8s-11be-org.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-2a-k8s-11be-org" {
  vpc_id            = aws_vpc.k8s-11be-org.id
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-2a"

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "us-east-2a.k8s.11be.org"
    SubnetType                           = "Public"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
    "kubernetes.io/role/elb"             = "1"
  }
}

resource "aws_vpc" "k8s-11be-org" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-11be-org" {
  domain_name         = "us-east-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                    = "k8s.11be.org"
    Name                                 = "k8s.11be.org"
    "kubernetes.io/cluster/k8s.11be.org" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-11be-org" {
  vpc_id          = aws_vpc.k8s-11be-org.id
  dhcp_options_id = aws_vpc_dhcp_options.k8s-11be-org.id
}

terraform {
  required_version = ">= 0.12"
}
