# terraform {
#   backend "s3" {
#     bucket         = "pbl182022"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }


terraform {
    backend "remote" {
        organization = "yorman" 
            workspaces {
                name = "terraform_cloud"
            }        
    }
}