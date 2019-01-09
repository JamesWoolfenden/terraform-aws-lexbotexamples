$env:AWS_PROFILE="saml"
$allslots=aws lex-models  get-slot-types |convertfrom-json
$slottypename="FlowerTypes"
$region="eu-west-1"

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
       return aws lex-models put-slot-type --region $region --name $slottypename
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

put-slottypes -slottypename $slottypename
