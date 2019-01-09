$env:AWS_PROFILE="saml"
$allintents=aws lex-models  get-intents|convertfrom-json
$intentname="OrderFlowers"

function get-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       $intent=$allintents.intents|Where-Object {[string]$_.name -eq $intentname}
       #no fAIL
       return aws lex-models get-intent --region eu-west-1 --name $intentname --intent-version '$LATEST'
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

get-intent -intentname $intentname| set-content .\output\intent-$intentname.json
