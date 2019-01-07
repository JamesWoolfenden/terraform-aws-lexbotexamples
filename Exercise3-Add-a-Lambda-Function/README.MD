# Exercise 3
## imports
Existing objects were imported into terraform state and then reverse engineered:
~~~
terraform import aws_lambda_function.OrderFlowersCodeHook OrderFlowersCodeHook
terraform import aws_iam_role.LexOrderFlowersRole LexOrderFlowersRole
terraform import aws_iam_role_policy_attachment.LexOrderFlowers LexOrderFlowersRole/arn:aws:iam::553700203877:policy/service-role/AWSLambdaBasicExecutionRole-fa3203d9-0958-4e45-89d3-412d6e9f7c53

terraform import aws_iam_policy.LexOrderFlowers arn:aws:iam::553700203877:policy/service-role/AWSLambdaBasicExecutionRole-fa3203d9-0958-4e45-89d3-412d6e9f7c53
~~~

Then back to 
https://docs.aws.amazon.com/lex/latest/dg/gs-cli-update-lambda.html

~~~
aws lambda add-permission --region eu-west-1 --function-name OrderFlowersCodeHook --statement-id LexGettingStarted-OrderFlowersBot --action lambda:InvokeFunction --principal lex.amazonaws.com --source-arn "arn:aws:lex:eu-west-1:553700203877:intent:OrderFlowers:*" --profile saml

aws lambda remove-permission --region eu-west-1 --function-name OrderFlowersCodeHook --statement-id LexGettingStarted-OrderFlowersBot --profile saml
~~~