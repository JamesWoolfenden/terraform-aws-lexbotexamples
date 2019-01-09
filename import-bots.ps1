$env:AWS_PROFILE="saml"
$allbots=aws lex-models  get-bots|convertfrom-json
$botname="OrderFlowersBot"
$region="eu-west-1"
function put-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       $bot=$allbots.bots|Where-Object {[string]$_.name -eq $botname}
       #no fAIL
       return aws lex-models put-bot --region $region --name $botname --locale en-US --no-child-directed
   }
   catch
   {
       write-host "$(Get-Date) - $bot Failure"
       exit
   }
}

if (!(Test-Path .\output))
{
    mkdir output
}

put-bot -botname $botname
