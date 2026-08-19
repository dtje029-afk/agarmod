# Complete setup script for Agar.io Shark mod

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Agar.io Shark - Setup & Push to GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Copy base app
Write-Host "[1/4] Copying base agar.io app..." -ForegroundColor Green
& "$PSScriptRoot\copy_base_app.ps1"

# Step 2: Initialize git
Write-Host ""
Write-Host "[2/4] Initializing Git repository..." -ForegroundColor Green
git init
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Git initialized" -ForegroundColor Green
}

# Step 3: Add files
Write-Host ""
Write-Host "[3/4] Adding files to Git..." -ForegroundColor Green
git add .
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Files added" -ForegroundColor Green
}

# Step 4: Commit
Write-Host ""
Write-Host "[4/4] Creating initial commit..." -ForegroundColor Green
git commit -m "Initial commit - Agar.io Shark mod setup"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Commit created" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✓ Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Create a new repository on GitHub" -ForegroundColor White
Write-Host "2. Run these commands:" -ForegroundColor White
Write-Host ""
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/agario-shark.git" -ForegroundColor Cyan
Write-Host "   git branch -M main" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. GitHub Actions will automatically build your IPA!" -ForegroundColor Green
Write-Host "4. Download from: Repo → Actions → Latest workflow → Artifacts" -ForegroundColor Green
Write-Host ""
