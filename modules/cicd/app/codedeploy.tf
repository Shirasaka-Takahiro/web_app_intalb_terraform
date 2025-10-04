##CodeDeploy
resource "aws_codedeploy_app" "default" {
  compute_platform = "ECS"
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}"
}

resource "aws_codedeploy_deployment_group" "default" {
  app_name              = aws_codedeploy_app.default.name
  deployment_group_name = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-deployment-group"

  service_role_arn       = aws_iam_role.codedeploy.arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 30
    }
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb_https_listener_arn]
      }

      target_group {
        name = var.blue_tg_name
      }

      target_group {
        name = var.green_tg_name
      }
    }
  }

}