param(
[string]$slottypename="FlowerTypes",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

Write-host "Region:       $region"
Write-host "slottypename: $slottypename"
function remove-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   try
   {
       $slottype=$allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}
       #no fAIL
       $result=aws lex-models delete-slot-type --region $region --name $slottypename

       If ($lastexitcode)
       {
           throw "Delete Failure:$result"
       }

       write-host "$(Get-Date) - $slottypename Deleted"

       return $result
   }
   catch
   {
       $_
       write-host "$(Get-Date) - Delete $slottypename Failure"
       exit
   }
}

remove-slottypes -slottypename $slottypename
