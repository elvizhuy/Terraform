resource "aws_s3_bucket" "development" {
    bucket = "dev-9890"
    tags = {
    Description = "devops"
    }
}

resource "aws_s3_object" "dev" {
    content = "/home/huynn/devops.txt"
    key = "devops.txt"
    bucket = aws_s3_bucket.development.id
}

data "aws_iam_group" "terra-group" {
    group_name = "terra-group"
}