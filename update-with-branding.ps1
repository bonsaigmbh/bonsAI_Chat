# bonsAI Chat - Automatischer Update-Prozess
Write-Host "Starting bonsAI Chat update process..." -ForegroundColor Cyan

# 1. Aktuelle Aenderungen committen
Write-Host "Committing current changes..." -ForegroundColor Yellow
git add .
git commit -m "chore: save current state before update"

# 2. Upstream Updates holen
Write-Host "Fetching updates from Open WebUI upstream..." -ForegroundColor Yellow
git fetch upstream

# 3. Merge durchfuehren
Write-Host "Merging upstream changes..." -ForegroundColor Yellow
git merge upstream/main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Merge conflicts detected! Please resolve manually and run:" -ForegroundColor Red
    Write-Host "   git add ." -ForegroundColor White
    Write-Host "   git commit -m 'resolve merge conflicts'" -ForegroundColor White
    Write-Host "   .\scripts\restore-branding.ps1" -ForegroundColor White
    exit 1
}

# 4. Branding wiederherstellen
Write-Host "Restoring bonsAI Chat branding..." -ForegroundColor Yellow
& ".\scripts\restore-branding.ps1"

# 5. Branding-Aenderungen committen
Write-Host "Committing branding changes..." -ForegroundColor Yellow
git add .
git commit -m "chore: restore bonsAI Chat branding after upstream merge"

Write-Host "Update complete!" -ForegroundColor Green
Write-Host "Please test the application thoroughly before pushing to origin." -ForegroundColor Cyan
Write-Host "When ready, push with: git push origin main" -ForegroundColor White