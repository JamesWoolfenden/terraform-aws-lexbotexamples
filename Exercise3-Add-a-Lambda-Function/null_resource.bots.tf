resource "null_resource" "bots" {
  triggers = {
    rerun = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "aws lex-models put-bot --region ${var.region} --name ${var.bots} --cli-input-json file://${var.bots}.json"
    when    = "create"
  }

  provisioner "local-exec" {
    command    = "aws lex-models delete-bot --region ${var.region} --name ${var.bots} "
    when       = "destroy"
    on_failure = "continue"
  }

  depends_on = ["null_resource.intents"]
}
