$env:AWS_PROFILE="saml"
$allslots=aws lex-models  get-slot-types |convertfrom-json
$slottypename="FlowerTypes"
$region="eu-west-1"

function get-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       $slottype=$allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}
       #no fAIL
       return aws lex-models get-slot-type --region $region --name $slottypename --slot-type-version '$LATEST'
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

get-slottypes -slottypename $slottypename| set-content .\output\slottype-$slottypename.json
