resource "aws_codebuild_project" "project" {
  name         = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-project"
  description  = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-project"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "REGION"
      value = var.region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.self.account_id
    }

    environment_variable {
      name  = "project"
      value = var.general_config["project"]
    }

    environment_variable {
      name  = "env"
      value = var.general_config["env"]
    }

    environment_variable {
      name  = "service"
      value = var.general_config["service"]
    }

    environment_variable {
      name  = "execution_role_arn"
      value = var.execution_role_arn
    }

    environment_variable {
      name  = "task_role_arn"
      value = var.execution_role_arn
    }

    environment_variable {
      name  = "ECR_REPOSITORY_APP_WEB_URL"
      value = var.ecr_repository_app_web_url
    }

    environment_variable {
      name  = "ECR_REPOSITORY_URL"
      value = var.ecr_repository_url
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  source {
    type                = "CODEPIPELINE"
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    buildspec           = var.buildspec_path
  }

  vpc_config {
    vpc_id  = var.vpc_id
    subnets = var.dmz_subnet_ids
    security_group_ids = [
      var.internal_sg_id
    ]
  }
}