##Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "defult" {
  name              = "/ecs/${var.general_config["project"]}/${var.general_config["env"]}/${var.general_config["service"]}"
  retention_in_days = 30
}