param(
[string]$region="eu-west-1",
[string]$intentname="OrderFlowers",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - IntentName: $intentname"

function update-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       if (!($allintents.intents|Where-Object {[string]$_.name -eq $intentname}))
       {
           Write-Host "$(get-date) - no existing intents of $intentname found"
           return $False
       }
       $intent=aws lex-models get-intent --region $region --name $intentname --intent-version '$LATEST'|ConvertFrom-Json

       $result=aws lex-models put-intent --region $region --name $intentname --checksum $($intent.checksum) --cli-input-json file://.\output\$intentname.json

       if ($lastexitcode)
       {
          throw "$lastexitcode import write failure"
       }

       Write-Host "$(get-date) - Intent $intentname updated"
       return $result
   }
   catch
   {
       $_
       write-host "$(Get-Date) - $intentname update Failure"
       exit
   }
}


update-intent -intentname $intentname
