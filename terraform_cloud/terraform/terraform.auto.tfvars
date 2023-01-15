region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "devops"

ami-bastion = "ami-07fc709436b09209b"

ami-nginx = "ami-03db25acdbee4dbde"

ami-sonar = "ami-0b2538dd66aef3442"

ami-web = "ami-0ef70f2fcaa848dcb"

keypair = "dareyprojKP"

account_no = "316136048935"

master-username = "admin"

master-password = "password"

db-name = "yormadb"
tags = {
  Owner-Email     = "devops@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "89938890"
}