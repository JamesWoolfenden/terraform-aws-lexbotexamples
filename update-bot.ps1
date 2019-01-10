param(
[string]$region="eu-west-1",
[string]$botname="OrderFlowersBot",
[string]$profile="saml")
$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - botname:    $botname"

function update-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       if (!($allbots.bots|Where-Object {[string]$_.name -eq $botname}))
       {
           Write-Host "$(get-date) - no existing bots of $botname found"
           exit
       }
       $bot=aws lex-models get-bot --region $region --name $botname --version-or-alias '$LATEST'|convertfrom-json
       Write-host "$(get-date) - Get bot details $($bot.name)"

       $result=aws lex-models put-bot --region $region --name $botname --checksum $($bot.checksum) --locale en-US --no-child-directed --cli-input-json file://.\output\$botname.json
       if ($lastexitcode)
       {
          throw "$lastexitcode update bot failure"
       }

       Write-Host "$(get-date) - bot $botname updated"
       return $result
    }
   catch
   {
       $_
       write-host "$(Get-Date) - $botname update Failure"
       exit
   }
}

update-bot -botname $botname
