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

   try
   {
       if (!($allintents.intents|Where-Object {[string]$_.name -eq $intentname}))
       {
           Write-Host "$(get-date) - no existing intents of $intentname found"
           exit
       }

       $intent=aws lex-models get-intent --region $region --name $intentname --intent-version '$LATEST'
       Write-host "$(get-date) - Get intent details $($intent.name)"
       if ($lastexitcode)
       {
           throw "Failed to get bot $botname"
       }

       $intent=$intent|Where-Object {$_ -notmatch '"version"'}
       $intent=$intent|Where-Object {$_ -notmatch 'lastUpdatedDate'}
       $intent=$intent|Where-Object {$_ -notmatch 'createdDate'}
       $intent=$intent|Where-Object {$_ -notmatch 'checksum'}

       $intent|set-content .\output\intent\$intentname.json  -Encoding Ascii
       write-host "$(Get-Date) - $intentname exported"
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

if (!(Test-Path .\output\intent))
{
    mkdir output\intent
}

get-intent -intentname $intentname
