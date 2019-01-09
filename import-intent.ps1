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
       if ($allintents.intents|Where-Object {[string]$_.name -eq $intentname})
       {
           Write-Host "preexisting intents of $botname found"
           return $False
       }
       #no fAIL
       return aws lex-models put-intent --region eu-west-1 --name $intentname
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
