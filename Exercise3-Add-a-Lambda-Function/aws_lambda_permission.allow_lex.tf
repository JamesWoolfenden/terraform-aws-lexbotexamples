resource "aws_lambda_permission" "allow_lex" {
  statement_id  = "LexGettingStarted-OrderFlowersBot"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.OrderFlowersCodeHook.function_name}"
  principal     = "lex.amazonaws.com"
  source_arn    = "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:intent:OrderFlowers:*"
  depends_on    = ["null_resource.intents"]
}
