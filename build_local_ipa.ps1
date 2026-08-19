# build_local_ipa.ps1 - Package agar.io IPA locally on Windows
param (
    [string]$DylibPath = "
)

$ErrorActionPreference = Stop
$workspace = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $workspace

Write-Host ====================================== -ForegroundColor Cyan
Write-Host  Agar.io Mod - Local IPA Packager      -ForegroundColor Cyan
Write-Host ====================================== -ForegroundColor Cyan

$payloadApp = Join-Path $workspace Payload\agar.io.app
$frameworks = Join-Path $payloadApp Frameworks

if (-not (Test-Path $payloadApp)) {
 Write-Host [-] Payload/agar.io.app niet gevonden! -ForegroundColor Red
 Write-Host     Zorg dat de Payload folder in deze directory staat. -ForegroundColor Yellow
 exit 1
}

if (-not (Test-Path $frameworks)) {
 New-Item -ItemType Directory -Path $frameworks -Force | Out-Null
}

if ($DylibPath -and (Test-Path $DylibPath)) {
 Write-Host [+] Dylib importeren: $DylibPath -ForegroundColor Green
 Copy-Item $DylibPath (Join-Path $frameworks dtje029mod.dylib) -Force
 Copy-Item $DylibPath (Join-Path $frameworks sharkmod.dylib) -Force
} else {
 $dlDylib = Join-Path $env:USERPROFILE Downloads\dtje029mod.dylib
 $localDylib = Join-Path $workspace dtje029mod.dylib
 
 if (Test-Path $localDylib) {
 Write-Host [+] Gevonden in workspace: $localDylib -ForegroundColor Green
 Copy-Item $localDylib (Join-Path $frameworks dtje029mod.dylib) -Force
 Copy-Item $localDylib (Join-Path $frameworks sharkmod.dylib) -Force
 } elseif (Test-Path $dlDylib) {
 Write-Host [+] Gevonden in Downloads: $dlDylib -ForegroundColor Green
 Copy-Item $dlDylib (Join-Path $frameworks dtje029mod.dylib) -Force
 Copy-Item $dlDylib (Join-Path $frameworks sharkmod.dylib) -Force
 } else {
 Write-Host [*] Geen nieuwe dtje029mod.dylib meegegeven; bestaande Frameworks worden gebruikt. -ForegroundColor Yellow
 }
}

$outputZip = Join-Path $workspace agario_dtje029.zip
$outputIpa = Join-Path $workspace agario_dtje029.ipa

if (Test-Path $outputZip) { Remove-Item $outputZip -Force }
if (Test-Path $outputIpa) { Remove-Item $outputIpa -Force }

Write-Host [+] Packaging Payload into agario_dtje029.ipa... -ForegroundColor Green
Compress-Archive -Path (Join-Path $workspace Payload) -DestinationPath $outputZip -Force
Move-Item $outputZip $outputIpa -Force

$ipaSize = [math]::Round(((Get-Item $outputIpa).Length / 1MB), 2)
Write-Host ====================================== -ForegroundColor Cyan
Write-Host [SUCCESS] IPA succesvol gebouwd! -ForegroundColor Green
Write-Host Locatie: $outputIpa ($ipaSize MB) -ForegroundColor Yellow
Write-Host Je kunt deze IPA direct installeren met TrollStore / ESign / Scarlet / Sideloadly. -ForegroundColor Cyan
Write-Host ====================================== -ForegroundColor Cyan
