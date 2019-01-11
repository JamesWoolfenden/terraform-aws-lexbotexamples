param(
[string]$region="eu-west-1",
[string]$slottypename="FlowerTypes",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allslots=aws lex-models  get-slot-types |convertfrom-json

Write-host "$(Get-Date) - Region:       $region"
Write-host "$(Get-Date) - slottypename: $slottypename"
function get-slottypes {
    param(
        [Parameter(Mandatory=$true)]
        [string]$slottypename)

   try
   {
       if (!($allslots.slotTypes|Where-Object {[string]$_.name -eq $slottypename}))
       {
          Write-Host "$(get-date) - no existing slot of $slottypename found"
          exit
       }

       $slots=aws lex-models get-slot-type --region $region --name $slottypename --slot-type-version '$LATEST'
       Write-host "$(get-date) - Get intent details $($slots.name)"
       if ($lastexitcode)
       {
           throw "Failed to get slotype $slottypename"
       }

       $slots=$slots|Where-Object {$_ -notmatch 'version'}
       $slots=$slots|Where-Object {$_ -notmatch 'lastUpdatedDate'}
       $slots=$slots|Where-Object {$_ -notmatch 'createdDate'}
       $slots=$slots|Where-Object {$_ -notmatch 'checksum'}

       $slots| set-content .\output\slottypes\$slottypename.json -Encoding Ascii|Out-Null
       write-host "$(Get-Date) - $slottypename exported"
       return
    }
   catch
   {
       $_
       write-host "$(Get-Date) - $slottype Failure"
       exit
   }
}

if (!(Test-Path .\output))
{
    mkdir output
}

if (!(Test-Path .\output\slottypes))
{
    mkdir output\slottypes
}

get-slottypes -slottypename $slottypename
