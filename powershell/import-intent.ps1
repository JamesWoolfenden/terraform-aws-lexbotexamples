param(
[string]$region="eu-west-1",
[string]$intentname="OrderFlowers",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - IntentName: $intentname"

function put-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   try
   {
       if ($allintents.intents|Where-Object {[string]$_.name -eq $intentname})
       {
           Write-Host "$(get-date) - preexisting intents of $intentname found"
           exit
       }


       $result=aws lex-models put-intent --region $region --name $intentname  --cli-input-json file://.\output\intent\$intentname.json

       if ($lastexitcode)
       {
          throw "$lastexitcode import intent failure"
       }
       Write-Host "$(get-date) - Intent $intentname written"
       return $result
   }
   catch
   {
       write-host "$(Get-Date) - $intentname Failure"
       exit
   }
}


put-intent -intentname $intentname
