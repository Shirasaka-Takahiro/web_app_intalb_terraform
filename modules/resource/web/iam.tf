##IAM Role
resource "aws_iam_role" "ecs" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-ecs-role"
  assume_role_policy = file("${path.module}/iam_json/fargate_task_assume_role.json")
}

##IAM Role Policy
resource "aws_iam_role_policy" "ecs" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-ecs-policy"
  role   = aws_iam_role.ecs.name
  policy = file("${path.module}/iam_json/task_execution_policy.json")
}