region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "devops"

ami-bastion = "ami-01b89d1df8d26fc1e"

ami-nginx = "ami-01abf7c46f672e9f2"

ami-sonar = "ami-07a30fb1a53f6032f"

ami-web = "ami-0fd483025ef5b1bed"

keypair = "dareyprojKP"

account_no = "316136048935"

master-username = "admin"

master-password = "password"

tags = {
  Owner-Email     = "devops@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "89938890"
}