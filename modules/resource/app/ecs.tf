##Task Definition
resource "aws_ecs_task_definition" "task" {
  family = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-task"
  container_definitions = templatefile("${path.module}/container_definition/container_definition.json",
    {
      project            = var.general_config["project"],
      env                = var.general_config["env"],
      service            = var.general_config["service"],
      ecr_repository_url = aws_ecr_repository.default.arn
    }
  )
  cpu                = var.fargate_cpu
  memory             = var.fargate_memory
  network_mode       = "awsvpc"
  execution_role_arn = aws_iam_role.ecs.arn
  task_role_arn      = aws_iam_role.ecs.arn

  requires_compatibilities = [
    "FARGATE"
  ]

  /*
  lifecycle {
    ignore_changes = [
      container_definitions
    ]
  }
  */
}

##Service
resource "aws_ecs_service" "service" {
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-service"
  cluster          = var.ecs_cluster_id
  task_definition  = aws_ecs_task_definition.task.arn
  desired_count    = var.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  load_balancer {
    target_group_arn = aws_lb_target_group.blue_tg.arn
    container_name   = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-container"
    container_port   = "80"
  }

  network_configuration {
    subnets = var.dmz_subnet_ids
    security_groups = [
      aws_security_group.internal.id
    ]
    assign_public_ip = false
  }

  deployment_controller {
    type = var.deployment_controller
  }
}