param(
[string]$botname="OrderFlowersBot",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile

$allbots=aws lex-models  get-bots|convertfrom-json
Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - botname:    $botname"
function remove-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       $bot=$allbots.bots|Where-Object {[string]$_.name -eq $botname}
       #no fAIL
       $result= aws lex-models delete-bot --region $region --name $botname
       if ($lastexitcode)
       {
          throw "$lastexitcode delete bot failure"
       }

       Write-Host "$(get-date) - bot $botname deleted"
      return $result
   }
   catch
   {
       write-host "$(Get-Date) - $bot Failure"
       exit
   }
}

remove-bot -botname $botname
