terraform {
    backend "s3" {
        bucket = "terraform-state-huynn"
        key = "devops/terraform.tfstate"
        region = "ap-southeast-1"
        dynamodb_table = "state-locking"
    }
}