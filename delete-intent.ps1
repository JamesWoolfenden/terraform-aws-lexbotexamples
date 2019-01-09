$env:AWS_PROFILE="saml"
$allintents=aws lex-models  get-intents|convertfrom-json
$intentname="OrderFlowers"

function remove-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       $intent=$allintents.intents|Where-Object {[string]$_.name -eq $intentname}
       #no fAIL
       return aws lex-models delete-intent --region eu-west-1 --name $intentname
   }
   catch
   {
       write-host "$(Get-Date) - $intent Failure"
       exit
   }
}

if (!(Test-Path .\output))
{
    mkdir output
}

remove-intent -intentname $intentname
