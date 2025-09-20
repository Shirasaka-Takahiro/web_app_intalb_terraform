##CodeBuild IAM Role
resource "aws_iam_role" "codebuild" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codebuild-role"
  assume_role_policy = file("${path.module}/iam_json/codebuild_assume_role.json")
}

##CodeBuild IAM Role Policy
resource "aws_iam_role_policy" "codebuild" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codebuild-policy"
  role   = aws_iam_role.codebuild.name
  policy = file("${path.module}/iam_json/codebuild_build_policy.json")
}

##CodeDeploy IAM Role
resource "aws_iam_role" "codedeploy" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codedeploy-role"
  assume_role_policy = file("${path.module}/iam_json/codedeploy_assume_role.json")
}

##CodeDeploy IAM Role Policy
resource "aws_iam_role_policy" "codedeploy" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codedeploy-policy"
  role   = aws_iam_role.codebuild.name
  policy = file("${path.module}/iam_json/codedeploy_deploy_policy.json")
}

##CodePipeline IAM Role
resource "aws_iam_role" "codepipeline" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codepipeline-role"
  assume_role_policy = file("${path.module}/iam_json/codepipeline_assume_role.json")
}

##CodePipeline IAM Role Policy
resource "aws_iam_role_policy" "codepipeline" {
  name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-codepipeline-policy"
  role   = aws_iam_role.codebuild.name
  policy = file("${path.module}/iam_json/codepipeline_pipeline_policy.json")
}