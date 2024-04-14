resource "aws_iam_user" "users" {
    name = var.users[count.index]
    count = length(var.users)
}

resource "aws_iam_group" "terra-group" {
    name = var.groups[count.index]
    lifecycle {
        ignore_changes = all
    }
}

data "aws_iam_group" "terra-group" {
    group_name = "terra-group"
    depends_on = [ aws_iam_group.terra-group ]
}

resource "aws_iam_policy_attachment" "full-access-policy-attachment" {
  name       = var.full-access-policy-attachment.name
  policy_arn = aws_iam_policy.full-access-policy.arn
  groups     = [data.aws_iam_group.terra-group.name]
}

resource "aws_iam_group_policy" "terra-group_policy" {
  name  = var.terra-group_policy.name
  group = aws_iam_group.terra-group.name
  policy = jsonencode(file("./policy.json"))
}