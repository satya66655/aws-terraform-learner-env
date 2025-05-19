resource "aws_iam_user" "user" {
  name = var.username
}

resource "aws_iam_user_login_profile" "login" {
  user                  = aws_iam_user.user.name
  password_length       = 12
  password_reset_required = true
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

data "aws_iam_policy_document" "region_restricted_admin" {
  statement {
    actions   = ["*"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [var.dedicated_region, var.common_region]
    }
  }

  statement {
    actions   = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:ListAccessKeys",
      "iam:DeleteAccessKey",
      "iam:GetUser",
      "iam:UpdateAccessKey"
    ]
    resources = ["arn:aws:iam::*:user/${var.username}"]
  }
}

resource "aws_iam_user_policy" "admin_region_restricted" {
  name   = "region-restricted-admin"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.region_restricted_admin.json
}

