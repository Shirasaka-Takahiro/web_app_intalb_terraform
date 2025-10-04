##Codepipeline
resource "aws_codepipeline" "pipeline" {
  name          = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-pipeline"
  role_arn      = aws_iam_role.codepipeline.arn
  pipeline_type = var.pipeline_type

  artifact_store {
    location = aws_s3_bucket.default_bucket.bucket
    type     = "S3"
  }

  ##Source Stage
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.default.arn
        FullRepositoryId = var.full_repositroy_id
        BranchName       = var.branch_name
      }
    }
  }

  ##Build Stage
  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.project.name
      }
    }
  }

  ##Deploy Stage
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.default.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.default.deployment_group_name
        TaskDefinitionTemplateArtifact = "build_output"
        TaskDefinitionTemplatePath     = var.task_definition_template_path
        AppSpecTemplateArtifact        = "build_output"
        AppSpecTemplatePath            = var.app_spec_template_path
      }
    }
  }
}