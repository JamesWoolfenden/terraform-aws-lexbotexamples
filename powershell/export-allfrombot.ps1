param(
[string]$botname="OrderFlowersBot",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - BotName:    $botname"
function get-intentsfrombot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   try
   {
       if (!($allbots.bots|Where-Object {[string]$_.name -eq $botname}))
       {
           Write-Host "$(get-date) - no existing bots of $botname found"
           exit
       }

       .\export-bot.ps1 -botname $botname -region $region

       $result=aws lex-models get-bot --region $region --name $botname --version-or-alias '$LATEST'|ConvertFrom-Json
       Write-host "$(get-date) - Get bot details $($bot.name)"
       if ($lastexitcode)
       {
           throw "Failed to get bot $botname"
       }

       foreach($intent in $result.intents.intentName){
           .\export-intent.ps1 -region $region -intentname $intent
           .\export-slotfromintent.ps1 -region $region -intentname $intent
       }
    }
   catch
   {
       $_
       write-host "$(Get-Date) - $intent Failure"
       exit
   }
}

if (!(Test-Path .\output))
{
    mkdir output
}

get-intentsfrombot -botname $botname
