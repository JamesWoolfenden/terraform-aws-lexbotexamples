resource "null_resource" "intents" {
  triggers = {
    rerun = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "sleep 60 & echo \"sleeping in PID $!\""
    when    = "destroy"
  }

  provisioner "local-exec" {
    command = "aws lex-models put-intent --region ${var.region} --name ${var.intents}  --cli-input-json file://${var.intentsfile}.json"
    when    = "create"
  }

  provisioner "local-exec" {
    command    = "aws lex-models delete-intent --region ${var.region} --name ${var.intents} "
    when       = "destroy"
    on_failure = "continue"
  }

  depends_on = ["null_resource.slot-type"]
}
