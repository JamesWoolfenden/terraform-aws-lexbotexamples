param(
[string]$region="eu-west-1",
[string]$intentname="OrderFlowers",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json


function put-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       if ($allintents.intents|Where-Object {[string]$_.name -eq $intentname})
       {
           Write-Host "preexisting intents of $intentname found"
           return $False
       }
       #no fAIL
       return aws lex-models put-intent --region $region --name $intentname --cli-input-json file://.\output\$intentname.json
   }
   catch
   {
       write-host "$(Get-Date) - $intent Failure"
       exit
   }
}


put-intent -intentname $intentname
