param(
[string]$region="eu-west-1",
[string]$slottypename="FlowerTypes",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

Write-host "$(Get-Date) - Region:       $region"
Write-host "$(Get-Date) - slottypename: $slottypename"

function update-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       if (!($allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}))
       {
          Write-Host "$(get-date) - no existing slot of $slottypename found"
          exit
       }

       $slot=aws lex-models get-slot-type --region $region --name $slottypename --slot-type-version '$LATEST'|convertfrom-json
       Write-host "$(get-date) - Get slot details $($slot.name)"

       $result=aws lex-models put-slot-type --region $region --checksum $($slot.checksum) --name $slottypename --cli-input-json file://.\output\slottypes\$slottypename.json
       if ($lastexitcode)
       {
           throw "Slot write failure"
       }
       Write-Host "$(get-date) - Slot $slottypename updated"
       return $result
    }
   catch
   {
       $_
       write-host "$(Get-Date) - $slottype update Failure"
       exit
   }
}


update-slottypes -slottypename $slottypename
