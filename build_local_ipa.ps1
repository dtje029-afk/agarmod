# build_local_ipa.ps1 - Package agar.io IPA locally on Windows
param (
    [string]$DylibPath = ""
)

$ErrorActionPreference = "Stop"
$workspace = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $workspace

Write-Host "======================================" -ForegroundColor Cyan
Write-Host " Agar.io Mod - Local IPA Packager     " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

$payloadApp = Join-Path $workspace "Payload\agar.io.app"
$frameworks = Join-Path $payloadApp "Frameworks"

if (-not (Test-Path $payloadApp)) {
    Write-Host "[-] Payload/agar.io.app niet gevonden!" -ForegroundColor Red
    Write-Host "    Zorg dat de Payload folder in deze directory staat." -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path $frameworks)) {
    New-Item -ItemType Directory -Path $frameworks -Force | Out-Null
}

if ($DylibPath -and (Test-Path $DylibPath)) {
    Write-Host "[+] Dylib importeren: $DylibPath" -ForegroundColor Green
    Copy-Item $DylibPath (Join-Path $frameworks "dtje029mod.dylib") -Force
    Copy-Item $DylibPath (Join-Path $frameworks "sharkmod.dylib") -Force
} else {
    $dlDylib = Join-Path $env:USERPROFILE "Downloads\dtje029mod.dylib"
    $localDylib = Join-Path $workspace "dtje029mod.dylib"
    
    if (Test-Path $localDylib) {
        Write-Host "[+] Gevonden in workspace: $localDylib" -ForegroundColor Green
        Copy-Item $localDylib (Join-Path $frameworks "dtje029mod.dylib") -Force
        Copy-Item $localDylib (Join-Path $frameworks "sharkmod.dylib") -Force
    } elseif (Test-Path $dlDylib) {
        Write-Host "[+] Gevonden in Downloads: $dlDylib" -ForegroundColor Green
        Copy-Item $dlDylib (Join-Path $frameworks "dtje029mod.dylib") -Force
        Copy-Item $dlDylib (Join-Path $frameworks "sharkmod.dylib") -Force
    } else {
        Write-Host "[*] Geen nieuwe dtje029mod.dylib meegegeven; bestaande Frameworks worden gebruikt." -ForegroundColor Yellow
    }
}

$outputIpa = Join-Path $workspace "agario_dtje029.ipa"

if (Test-Path $outputIpa) { Remove-Item $outputIpa -Force }

Write-Host "[+] Packaging Payload into agario_dtje029.ipa (iOS format)..." -ForegroundColor Green

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$payloadDir = Join-Path $workspace "Payload"
$zipStream = [System.IO.File]::Create($outputIpa)
$archive = New-Object System.IO.Compression.ZipArchive($zipStream, [System.IO.Compression.ZipArchiveMode]::Create)

$files = Get-ChildItem -Path $payloadDir -Recurse -File
foreach ($file in $files) {
    # iOS / ESign requires standard UNIX forward slash paths
    $relPath = $file.FullName.Substring($workspace.Length + 1).Replace('\', '/')
    $entry = $archive.CreateEntry($relPath, [System.IO.Compression.CompressionLevel]::Optimal)
    $entryStream = $entry.Open()
    $fileStream = [System.IO.File]::OpenRead($file.FullName)
    $fileStream.CopyTo($entryStream)
    $fileStream.Dispose()
    $entryStream.Dispose()
}

$archive.Dispose()
$zipStream.Dispose()

$ipaSize = [math]::Round(((Get-Item $outputIpa).Length / 1MB), 2)
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] IPA succesvol gebouwd!" -ForegroundColor Green
Write-Host "Locatie: $outputIpa ($ipaSize MB)" -ForegroundColor Yellow
Write-Host "Je kunt deze IPA direct installeren met TrollStore / ESign / Scarlet / Sideloadly." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
