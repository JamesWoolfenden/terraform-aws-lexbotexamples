param(
[string]$region="eu-west-1",
[string]$slottypename="FlowerTypes",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

function put-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       if ($allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename})
       {
           Write-Host "preexisting slot of $slottypename found"
           return $False
       }
       #no fAIL
       return aws lex-models put-slot-type --region $region --name $slottypename --cli-input-json file://.\output\$slottypename.json
   }
   catch
   {
       write-host "$(Get-Date) - $slottype Failure"
       exit
   }
}


put-slottypes -slottypename $slottypename
