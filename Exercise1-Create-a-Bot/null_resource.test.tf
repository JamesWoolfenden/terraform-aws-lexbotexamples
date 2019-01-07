resource "null_resource" "tests" {
  provisioner "local-exec" {
    command = "sleep 60 & echo \"sleeping in PID $!\""
    when    = "create"
  }

  provisioner "local-exec" {
    command = "aws lex-runtime post-text --region ${var.region} --bot-name ${var.bots} --bot-alias \"\\$LATEST\"  --user-id UserOne --input-text 'i would like to order flowers'"
    when    = "create"
  }
}
