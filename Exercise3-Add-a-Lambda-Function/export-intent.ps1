$env:AWS_PROFILE="saml"
$allintents=aws lex-models  get-intents|convertfrom-json
$intentname="OrderFlowers"

function get-intent {

try{
$intent=$allintents.intents|where {[string]$_.name -eq $intentname}
#no fAIL
return aws lex-models get-intent --region eu-west-1 --name $intentname --intent-version '$LATEST'|convertfrom-json
}
catch{
write-host "$(date) - $intent Failure"
#put-intent
return
}
}
