resource "aws_s3_bucket" "development" {
    bucket = var.bucket_name
    tags = {
    Description = "devops"
    }
}

resource "aws_s3_object" "dev" {
    content = var.content
    key = "devops.txt"
    bucket = aws_s3_bucket.development.id
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.development.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_group" "terra-group" {
    group_name = "terra-group"
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_group.terra-group.arn]
    }
    actions = ["*"]

    resources = [
      aws_s3_bucket.development.arn,
      "${aws_s3_bucket.development.arn}/*",
    ]
  }
}