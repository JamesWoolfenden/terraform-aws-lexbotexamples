param(
[string]$intentname="OrderFlowers",
[string]$region="eu-west-1",
[string]$profile="saml")

$env:AWS_PROFILE=$profile
$allintents=aws lex-models  get-intents|convertfrom-json

function remove-intent {
    param(
        [Parameter(Mandatory=$true)]
        [string]$intentname)

   try
   {
       $intent=$allintents.intents|Where-Object {[string]$_.name -eq $intentname}
       #no fAIL
       $result=aws lex-models delete-intent --region $region --name $intentname
       if ($lastexitcode)
       {
          throw "$lastexitcode delete failure"
       }
       return $result
   }
   catch
   {
       write-host "$(Get-Date) - $intent Failure"
       write-host "$(Get-Date) - Have you deleted the associated bot first?"

       exit
   }
}

remove-intent -intentname $intentname
