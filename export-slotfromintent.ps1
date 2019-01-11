param(
[string]$region="eu-west-1",
[string]$intentname="OrderFlowers",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - IntentName: $intentname"

function get-slotsfromintent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   try
   {
       if (!($allintents.intents|Where-Object {[string]$_.name -eq $intentname}))
       {
           Write-Host "$(get-date) - no existing intents of $intentname found"
           exit
       }

       $intent=aws lex-models get-intent --region $region --name $intentname --intent-version '$LATEST'|ConvertFrom-Json

       foreach($slot in $intent.slots.slottype)
       {
           .\export-slottypes.ps1 -region $region -slottypename $slot
       }

       return
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

get-slotsfromintent -intentname $intentname
