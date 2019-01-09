param(
[string]$botname="OrderFlowersBot",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json


function get-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       $bot=$allbots.bots|Where-Object {[string]$_.name -eq $botname}
       #no fAIL
       return aws lex-models get-bot --region $region --name $botname --version-or-alias '$LATEST'
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

get-bot -botname $botname |convertto-json | set-content .\output\bot-$botname.json -Encoding UTF8
