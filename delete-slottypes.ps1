$env:AWS_PROFILE="saml"
$allslots=aws lex-models  get-slot-types |convertfrom-json
$slottypename="FlowerTypes"
$region="eu-west-1"

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

if (!(Test-Path .\output))
{
    mkdir output
}

remove-slottypes -slottypename $slottypename| set-content .\output\slottype-$slottypename.json
