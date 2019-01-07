https://docs.aws.amazon.com/lex/latest/dg/gs-create-role.html

### one off creation of service linked account
Using the aws profile saml

- aws iam create-service-linked-role --aws-service-name lex.amazonaws.com --profile saml

- aws iam get-role --role-name AWSServiceRoleForLexBots --profile saml
~~~
terraform import  aws_iam_service_linked_role.lexbots arn:aws:iam::010101010101:role/aws-service-role/lex.amazonaws.com/AWSServiceRoleForLexBots
~~~

As i have multiple implementations of lex so formv  this role i dont want to include it as a destroy would have fairly negative effect. YMMV.

## Issues
- I had to bump the permission of devops role to have permission with lex. This was dont in devtest so im sure i wont have it in prod.

## Profiles
- Im using a profile for aws called saml, how did i get the null-resource to use the context of that profile?
Well i just cheated by setting and env var. Hackly!
~~~
export AWS_PROFILE="saml"
~~~

If you change your intents files you will neeed to run:
~~~
make taint
~~~

This will taint the bots, intents and slots so they can be updated.