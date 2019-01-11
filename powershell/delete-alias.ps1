param(
[string]$botname="OrderFlowersBot")

aws lex-models delete-bot-alias --name Flowers --bot-name $botname
