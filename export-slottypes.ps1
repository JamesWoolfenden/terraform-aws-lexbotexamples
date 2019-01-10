param(
[string]$region="eu-west-1",
[string]$slottypename="FlowerTypes",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

function get-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   [string]$intent

   try
   {
       $slottype=$allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}
       #no fAIL
       $slots=aws lex-models get-slot-type --region $region --name $slottypename --slot-type-version '$LATEST'
       $slots=$slots|Where-Object {$_ -notmatch 'version'}
       $slots=$slots|Where-Object {$_ -notmatch 'lastUpdatedDate'}
       $slots=$slots|Where-Object {$_ -notmatch 'createdDate'}
       $slots=$slots|Where-Object {$_ -notmatch 'checksum'}

       return $slots
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

get-slottypes -slottypename $slottypename | set-content .\output\$slottypename.json -Encoding Ascii
