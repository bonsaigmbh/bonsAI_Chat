# bonsAI Chat - Branding Restore Script
# Dieses Skript stellt nach einem Upstream-Update das bonsAI Chat Branding wieder her

Write-Host "🌳 Restoring bonsAI Chat branding..." -ForegroundColor Green

# 1. Package.json
Write-Host "📦 Updating package.json..."
$packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json
$packageJson.name = "bonsai-chat"
$packageJson | ConvertTo-Json -Depth 100 | Set-Content "package.json"

# 2. App HTML
Write-Host "🌐 Updating src/app.html..."
(Get-Content "src/app.html") -replace 'content="Open WebUI"', 'content="bonsAI Chat"' -replace '<title>Open WebUI</title>', '<title>bonsAI Chat</title>' | Set-Content "src/app.html"

# 3. OpenSearch XML
Write-Host "🔍 Updating static/opensearch.xml..."
(Get-Content "static/opensearch.xml") -replace '<ShortName>Open WebUI</ShortName>', '<ShortName>bonsAI Chat</ShortName>' -replace '<Description>Search Open WebUI</Description>', '<Description>Search bonsAI Chat</Description>' | Set-Content "static/opensearch.xml"

# 4. Web App Manifest
Write-Host "📱 Updating static/static/site.webmanifest..."
(Get-Content "static/static/site.webmanifest") -replace '"name": "Open WebUI"', '"name": "bonsAI Chat"' -replace '"short_name": "WebUI"', '"short_name": "bonsAI"' | Set-Content "static/static/site.webmanifest"

# 5. Backend manifest
Write-Host "🔧 Updating backend/open_webui/static/site.webmanifest..."
if (Test-Path "backend/open_webui/static/site.webmanifest") {
    (Get-Content "backend/open_webui/static/site.webmanifest") -replace '"name": "Open WebUI"', '"name": "bonsAI Chat"' | Set-Content "backend/open_webui/static/site.webmanifest"
}

# 6. Frontend Notifications
Write-Host "🔔 Updating frontend notifications..."
(Get-Content "src/routes/+layout.svelte") -replace 'Open WebUI', 'bonsAI Chat' | Set-Content "src/routes/+layout.svelte"

# 7. Admin pages
Write-Host "⚙️ Updating admin pages..."
Get-ChildItem -Path "src/routes/(app)" -Recurse -Filter "*.svelte" | ForEach-Object {
    (Get-Content $_.FullName) -replace 'Open WebUI version', 'bonsAI Chat version' | Set-Content $_.FullName
}

# 8. Backend error messages and config
Write-Host "🚨 Updating backend error messages and config..."
if (Test-Path "backend/open_webui/routers/openai.py") {
    (Get-Content "backend/open_webui/routers/openai.py") -replace 'Open WebUI:', 'bonsAI Chat:' -replace '"Open WebUI"', '"bonsAI Chat"' | Set-Content "backend/open_webui/routers/openai.py"
}
if (Test-Path "backend/open_webui/env.py") {
    (Get-Content "backend/open_webui/env.py") -replace '"Open WebUI"\)', '"bonsAI Chat")' | Set-Content "backend/open_webui/env.py"
}

# 9. Copy logos
Write-Host "🖼️ Restoring logos..."
if (Test-Path "static/static/Bonsai_Logo_ohne research.png") {
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon.ico" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon-96x96.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon-dark.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/apple-touch-icon.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/web-app-manifest-192x192.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/web-app-manifest-512x512.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/static/logo.png" -Force
    Copy-Item "static/static/Bonsai_Logo_ohne research.png" "static/favicon.png" -Force
    
    if (Test-Path "backend/open_webui/static/favicon.png") {
        Copy-Item "static/static/Bonsai_Logo_ohne research.png" "backend/open_webui/static/favicon.png" -Force
    }
    if (Test-Path "backend/open_webui/static/logo.png") {
        Copy-Item "static/static/Bonsai_Logo_ohne research.png" "backend/open_webui/static/logo.png" -Force
    }
}

Write-Host "✅ bonsAI Chat branding restored successfully!" -ForegroundColor Green
Write-Host "🔄 You may need to restart the dev server to see all changes." -ForegroundColor Yellow
