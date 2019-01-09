$env:AWS_PROFILE="saml"
$allbots=aws lex-models  get-bots|convertfrom-json
$botname="OrderFlowersBot"
$region="eu-west-1"
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

if (!(Test-Path .\output))
{
    mkdir output
}

remove-bot -botname $botname
