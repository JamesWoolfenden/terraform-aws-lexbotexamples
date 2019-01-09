param(
[string]$slottypename="FlowerTypes",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

function remove-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       $slottype=$allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}
       #no fAIL
       return aws lex-models delete-slot-type --region $region --name $slottypename
   }
   catch
   {
       write-host "$(Get-Date) - $slottype Failure"
       exit
   }
}

remove-slottypes -slottypename $slottypename
