param(
[string]$intentname="OrderFlowers",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

function remove-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       $intent=$allintents.intents|Where-Object {[string]$_.name -eq $intentname}
       #no fAIL
       return aws lex-models delete-intent --region $region --name $intentname
   }
   catch
   {
       write-host "$(Get-Date) - $intent Failure"
       exit
   }
}

remove-intent -intentname $intentname
