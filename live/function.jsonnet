local tfstate = std.native("tfstate");
{
  "FunctionName": "lambrollExample",
  "Handler": "index.handler",
  "MemorySize": 128,
  // "Role": tfstate("module.role_created_by_module.outputs.role_arn.value"), // Not work
  // "Role": tfstate("outputs.role_arn.value"), // Not work
  // "Role": tfstate("aws_iam_role.lambroll_example2.arn"), // Work (but not role created by module)
  "Role": tfstate("module.role_created_by_module.aws_iam_role.lambroll_example.arn"), // Work
  "Runtime": "nodejs22.x",
  "Timeout": 3
}
