param(
[string]$region="eu-west-1",
[string]$slottypename="FlowerTypes",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

Write-host "$(Get-Date) - Region:       $region"
Write-host "$(Get-Date) - slottypename: $slottypename"

function put-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       if ($allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename})
       {
           Write-Host "$(get-date) - preexisting slot of $slottypename found"
           return $False
       }

       $result=aws lex-models put-slot-type --region $region --name $slottypename --cli-input-json file://.\output\$slottypename.json
       if ($lastexcode)
       {
           throw "Slot write failure"
       }
       Write-Host "$(get-date) - Slot $slottypename written"
       return $result
    }
   catch
   {
       write-host "$(Get-Date) - $slottype Failure"
       exit
   }
}


put-slottypes -slottypename $slottypename
