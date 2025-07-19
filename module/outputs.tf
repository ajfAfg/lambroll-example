output "role_arn" {
  value       = aws_iam_role.lambroll_example.arn
  description = "The ARN of the IAM role created by the module."
}
