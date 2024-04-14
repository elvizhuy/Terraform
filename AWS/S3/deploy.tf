resource "aws_s3_bucket" "development" {
  bucket = "dev-9890"
  tags = {
    Description = "devops"
  }
}