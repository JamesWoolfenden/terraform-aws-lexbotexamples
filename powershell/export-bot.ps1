param(
[string]$botname="OrderFlowersBot",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - BotName:    $botname"
function get-bot {
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
       $result=aws lex-models get-bot --region $region --name $botname --version-or-alias '$LATEST'
       Write-host "$(get-date) - Get bot details $($bot.name)"
       if ($lastexitcode)
       {
           throw "Failed to get bot $botname"
       }

       $result=$result|Where-Object {$_ -notmatch '"version"'}
       $result=$result|Where-Object {$_ -notmatch '"status"'}
       $result=$result|Where-Object {$_ -notmatch 'lastUpdatedDate'}
       $result=$result|Where-Object {$_ -notmatch 'createdDate'}
       $result=$result|Where-Object {$_ -notmatch 'checksum'}

       $result| set-content .\output\bot\$botname.json -Encoding Ascii
       write-host "$(Get-Date) - $botname exported"
       return
   }
   catch
   {
       $_
       write-host "$(Get-Date) - $botname export failure"
       exit
   }
}

if (!(Test-Path .\output))
{
    mkdir output
}

if (!(Test-Path .\output\bot))
{
    mkdir output\bot
}


get-bot -botname $botname
