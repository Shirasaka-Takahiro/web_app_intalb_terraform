##Codestar Connections Connection
resource "aws_codestarconnections_connection" "default" {
  name          = "${var.general_config["project"]}-${var.general_config["env"]}-${var.general_config["service"]}-connection"
  provider_type = "GitHub"
}