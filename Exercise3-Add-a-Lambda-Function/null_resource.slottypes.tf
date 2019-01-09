resource "null_resource" "slot-type" {
  triggers = {
    rerun = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "aws lex-models put-slot-type --region ${var.region} --name ${var.slottypes}  --cli-input-json file://${var.slottypes}.json"
    when    = "create"
  }

  provisioner "local-exec" {
    command    = "aws lex-models delete-slot-type --region ${var.region} --name ${var.slottypes} "
    when       = "destroy"
    on_failure = "continue"
  }
}
