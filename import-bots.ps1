param(
[string]$region="eu-west-1",
[string]$botname="OrderFlowersBot",
[string]$profile="saml")
$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json

function add-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       $bot=$allbots.bots|Where-Object {[string]$_.name -eq $botname}
       #no fAIL
       return aws lex-models put-bot --region $region --name $botname --locale en-US --no-child-directed --cli-input-json file://.\output\$botname.json
    }
   catch
   {
       write-host "$(Get-Date) - $bot Failure"
       exit
   }
}


add-bot -botname $botname
