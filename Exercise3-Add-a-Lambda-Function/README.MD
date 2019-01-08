# Exercise 3
## imports

There's dependency of the lamda permission and the intent. 
You cant update an intent to point at a lambda that doesnt exist and you cant add permission on lambda for an tent that doesnt exist.

So....
Obviously an intent has to exist first, just not necessairly the one you actually want.
from the docs:

> Use the Lambda AddPermission function to enable the OrderFlowers intent to call the Lambda Invoke operation.
>
> Use the GetIntent operation to get the intent from Amazon Lex.
>
> Update the intent to add the Lambda function.
>
> Use the PutIntent operation to send the updated intent back to Amazon Lex.
>
> Use the GetBot and PutBot operations to rebuild any bot that uses the intent.


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