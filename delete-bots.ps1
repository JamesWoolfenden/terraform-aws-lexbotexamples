param(
[string]$botname="OrderFlowersBot",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile

$allbots=aws lex-models  get-bots|convertfrom-json
function remove-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       $bot=$allbots.bots|Where-Object {[string]$_.name -eq $botname}
       #no fAIL
       return aws lex-models delete-bot --region $region --name $botname
   }
   catch
   {
       write-host "$(Get-Date) - $bot Failure"
       exit
   }
}

remove-bot -botname $botname
