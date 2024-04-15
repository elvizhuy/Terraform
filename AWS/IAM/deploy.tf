# resource "aws_iam_user" "users" {
#     name = var.users[count.index]
#     count = length(var.users)
# }

# resource "aws_iam_group" "terra-group" {
#     name = var.groups
#     lifecycle {
#         ignore_changes = all
#     }
# }

# data "aws_iam_group" "terra-group" {
#     group_name = "terra-group"
#     depends_on = [ aws_iam_group.terra-group ]
# }

# resource "aws_iam_policy_attachment" "full-access-policy-attachment" {
#   name       = var.full-access-policy-attachment
#   policy_arn = aws_iam_group_policy.terra-group_policy.arn
#   groups     = [data.aws_iam_group.terra-group.name]
# }

# resource "aws_iam_group_policy" "terra-group_policy" {
#   name  = var.terra-group_policy
#   group = aws_iam_group.terra-group.group_name
#   policy = file("./policy.json")
# }

resource "aws_iam_user" "users" {
    name = var.users[count.index]
    count = length(var.users)
}

resource "aws_iam_group" "terra-group" {
    for_each = { for idx, name in var.groups : idx => name }
    name = each.value
    lifecycle {
        ignore_changes = all
    }
}

resource "aws_iam_group_membership" "group_membership" {
#  for_each = aws_iam_user.users
#  name     = each.key
#  users    = [each.value.name]
  count    = length(var.users)
  name     = var.users[count.index]
  users    = [var.users[count.index]]
  group    = data.aws_iam_group.terra-group.group_name
}

data "aws_iam_group" "terra-group" {
    group_name = "terra-group"
    depends_on = [ aws_iam_group.terra-group ]
}

resource "aws_iam_group_policy" "terra-group_policy" {
  for_each = aws_iam_group.terra-group
  name  = "${each.key}-policy"
  group = each.key
  policy = file("./policy.json")
}

resource "aws_iam_policy_attachment" "full-access-policy-attachment" {
  for_each = aws_iam_group.terra-group
  name       = "${each.key}-full-access-policy-attachment"
  policy_arn = aws_iam_group_policy.terra-group_policy.group[each.key].arn
  groups     = [each.key]
  depends_on = [ aws_iam_group.terra-group,aws_iam_group_policy.terra-group_policy ]
}



