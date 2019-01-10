param(
[string]$region="eu-west-1",
[string]$botname="OrderFlowersBot",
[string]$profile="saml")
$env:AWS_PROFILE=$profile
$allbots=aws lex-models  get-bots|convertfrom-json

Write-host "$(Get-Date) - Region:     $region"
Write-host "$(Get-Date) - botname:    $botname"

function add-bot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$botname)

   [string]$bot

   try
   {
       if($allbots.bots|Where-Object {[string]$_.name -eq $botname})
       {
           Write-Host "$(get-date) - preexisting bot of $botname found"
           exit
       }

       $result= aws lex-models put-bot --region $region --name $botname --locale en-US --no-child-directed --cli-input-json file://.\output\$botname.json
       if ($lastexitcode)
       {
          throw "$lastexitcode import bot failure"
       }

       Write-Host "$(get-date) - bot $botname written"
       return $result
    }
   catch
   {
       $_
       write-host "$(Get-Date) - $bot Failure"
       exit
   }
}

add-bot -botname $botname
