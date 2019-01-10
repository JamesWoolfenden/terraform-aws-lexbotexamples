param(
[string]$region="eu-west-1",
[string]$intentname="OrderFlowers",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - IntentName: $intentname"

function get-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   [string]$intent

   try
   {
       $intent=$allintents.intents|Where-Object {[string]$_.name -eq $intentname}
       #no fAIL

       $intent=aws lex-models get-intent --region $region --name $intentname --intent-version '$LATEST'
       $intent=$intent|Where-Object {$_ -notmatch '"version"'}
       $intent=$intent|Where-Object {$_ -notmatch 'lastUpdatedDate'}
       $intent=$intent|Where-Object {$_ -notmatch 'createdDate'}
       $intent=$intent|Where-Object {$_ -notmatch 'checksum'}
       return $intent
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

Write-Host "$(get-date) - Writing out intent to .\output\$intentname.json"
get-intent -intentname $intentname  | set-content .\output\$intentname.json  -Encoding Ascii
