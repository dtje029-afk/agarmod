# Script to copy base agar.io app from shark to Payload

$sourcePath = "C:\Users\dtje0\Downloads\shark\_extract\Payload\agar.io.app"
$destPath = "C:\Users\dtje0\Desktop\dtje029mod\Payload\agar.io.app"

Write-Host "Copying base agar.io app..." -ForegroundColor Green

if (Test-Path $sourcePath) {
    # Remove destination if exists
    if (Test-Path $destPath) {
        Write-Host "Removing existing Payload/agar.io.app..." -ForegroundColor Yellow
        Remove-Item -Path $destPath -Recurse -Force
    }

    # Copy the app
    Copy-Item -Path $sourcePath -Destination $destPath -Recurse -Force

    Write-Host "✓ Base app copied successfully!" -ForegroundColor Green
    Write-Host ""

    # Show info
    $appSize = (Get-ChildItem -Path $destPath -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    $fileCount = (Get-ChildItem -Path $destPath -Recurse -File | Measure-Object).Count

    Write-Host "App size: $([math]::Round($appSize, 2)) MB" -ForegroundColor Cyan
    Write-Host "Files: $fileCount" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "✓ Ready to build and push to GitHub!" -ForegroundColor Green
} else {
    Write-Host "✗ Error: Source path not found: $sourcePath" -ForegroundColor Red
    Write-Host "Please check if the shark folder exists." -ForegroundColor Yellow
}
