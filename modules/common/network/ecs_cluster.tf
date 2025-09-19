##Cluster
resource "aws_ecs_cluster" "cluster" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}