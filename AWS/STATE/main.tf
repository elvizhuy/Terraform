resource "local_file" "test" {
    filename = "/home/huynn/devops.txt"
    content = "Hello"
}

resource "aws_dynamodb_table" "state-locking" {
    name = "state-locking"
    billing_mod = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}