# Script to fix Payload structure and copy base agar.io app

$sourcePath = "C:\Users\dtje0\Downloads\shark\_extract\Payload\agar.io.app"
$correctDestPath = "C:\Users\dtje0\Desktop\dtje029mod\Payload\agar.io.app"
$wrongDestPath = "C:\Users\dtje0\Desktop\dtje029mod\Payload\Payload"

Write-Host "Fixing Payload structure..." -ForegroundColor Green
Write-Host ""

# Check if wrong structure exists and fix it
if (Test-Path $wrongDestPath) {
    Write-Host "Found incorrect Payload/Payload structure. Fixing..." -ForegroundColor Yellow

    $wrongAppPath = "$wrongDestPath\agar.io.app"
    if (Test-Path $wrongAppPath) {
        # Move to correct location
        if (Test-Path $correctDestPath) {
            Remove-Item -Path $correctDestPath -Recurse -Force
        }
        Move-Item -Path $wrongAppPath -Destination $correctDestPath -Force

        # Remove wrong Payload folder
        Remove-Item -Path $wrongDestPath -Recurse -Force

        Write-Host "✓ Structure fixed!" -ForegroundColor Green
    }
}

# If correct path doesn't exist, copy from source
if (-not (Test-Path $correctDestPath)) {
    Write-Host "Copying base agar.io app from shark..." -ForegroundColor Green

    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $correctDestPath -Recurse -Force
        Write-Host "✓ Base app copied successfully!" -ForegroundColor Green
    } else {
        Write-Host "✗ Error: Source not found: $sourcePath" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Verifying structure..." -ForegroundColor Cyan

# Verify correct structure
if (Test-Path "$correctDestPath\Info.plist") {
    Write-Host "✓ Correct structure verified!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Structure:" -ForegroundColor Cyan
    Write-Host "  dtje029mod/" -ForegroundColor White
    Write-Host "  └── Payload/" -ForegroundColor White
    Write-Host "      └── agar.io.app/" -ForegroundColor Green
    Write-Host "          ├── agar.io" -ForegroundColor White
    Write-Host "          ├── Info.plist" -ForegroundColor White
    Write-Host "          └── ..." -ForegroundColor White
    Write-Host ""

    $appSize = (Get-ChildItem -Path $correctDestPath -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    $fileCount = (Get-ChildItem -Path $correctDestPath -Recurse -File | Measure-Object).Count

    Write-Host "App size: $([math]::Round($appSize, 2)) MB" -ForegroundColor Cyan
    Write-Host "Files: $fileCount" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "✓ Ready for GitHub!" -ForegroundColor Green
} else {
    Write-Host "✗ Error: Structure still incorrect" -ForegroundColor Red
    Write-Host "Expected: $correctDestPath\Info.plist" -ForegroundColor Yellow
}
