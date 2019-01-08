/*
On the Create function page, choose Blueprints.
Type lex- in the filter text box to find the blueprint, choose the lex-order-flowers-python blueprint.
Type a Lambda function name (OrderFlowersCodeHook).

For the IAM role, choose Create a new role from template(s).

Type a role name (LexOrderFlowersRole).

Leave the other default values.*/

resource "aws_lambda_function" "OrderFlowersCodeHook" {
  filename         = "${path.module}/files/lambda.zip"
  description      = "Order flowers, using Amazon Lex to perform natural language understanding"
  function_name    = "OrderFlowersCodeHook"
  role             = "${aws_iam_role.LexOrderFlowersRole.arn}"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = ""
  runtime          = "python2.7"

  timeout = "10"

  tags {
    "lambda-console:blueprint" = "lex-order-flowers-python"
  }
}
