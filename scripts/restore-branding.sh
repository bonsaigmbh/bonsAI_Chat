#!/bin/bash
# bonsAI Chat - Branding Restore Script (Linux/macOS)
# Dieses Skript stellt nach einem Upstream-Update das bonsAI Chat Branding wieder her

echo "🌳 Restoring bonsAI Chat branding..."

# 1. Package.json
echo "📦 Updating package.json..."
sed -i 's/"name": "open-webui"/"name": "bonsai-chat"/g' package.json

# 2. App HTML
echo "🌐 Updating src/app.html..."
sed -i 's/content="Open WebUI"/content="bonsAI Chat"/g' src/app.html
sed -i 's/<title>Open WebUI<\/title>/<title>bonsAI Chat<\/title>/g' src/app.html

# 3. OpenSearch XML
echo "🔍 Updating static/opensearch.xml..."
sed -i 's/<ShortName>Open WebUI<\/ShortName>/<ShortName>bonsAI Chat<\/ShortName>/g' static/opensearch.xml
sed -i 's/<Description>Search Open WebUI<\/Description>/<Description>Search bonsAI Chat<\/Description>/g' static/opensearch.xml

# 4. Web App Manifest
echo "📱 Updating static/static/site.webmanifest..."
sed -i 's/"name": "Open WebUI"/"name": "bonsAI Chat"/g' static/static/site.webmanifest
sed -i 's/"short_name": "WebUI"/"short_name": "bonsAI"/g' static/static/site.webmanifest

# 5. Backend manifest
echo "🔧 Updating backend/open_webui/static/site.webmanifest..."
if [ -f "backend/open_webui/static/site.webmanifest" ]; then
    sed -i 's/"name": "Open WebUI"/"name": "bonsAI Chat"/g' backend/open_webui/static/site.webmanifest
fi

# 6. Frontend Notifications
echo "🔔 Updating frontend notifications..."
sed -i 's/Open WebUI/bonsAI Chat/g' src/routes/+layout.svelte

# 7. Admin pages
echo "⚙️ Updating admin pages..."
find src/routes/\(app\) -name "*.svelte" -exec sed -i 's/Open WebUI version/bonsAI Chat version/g' {} \;

# 8. Backend error messages and config
echo "🚨 Updating backend error messages and config..."
if [ -f "backend/open_webui/routers/openai.py" ]; then
    sed -i 's/Open WebUI:/bonsAI Chat:/g' backend/open_webui/routers/openai.py
    sed -i 's/"Open WebUI"/"bonsAI Chat"/g' backend/open_webui/routers/openai.py
fi
if [ -f "backend/open_webui/env.py" ]; then
    sed -i 's/"Open WebUI")/"bonsAI Chat")/g' backend/open_webui/env.py
fi

# 9. Copy logos
echo "🖼️ Restoring logos..."
if [ -f "static/static/Bonsai_Logo_ohne research.png" ]; then
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon.ico"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon-96x96.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/favicon-dark.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/apple-touch-icon.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/web-app-manifest-192x192.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/web-app-manifest-512x512.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/static/logo.png"
    cp "static/static/Bonsai_Logo_ohne research.png" "static/favicon.png"
    
    if [ -f "backend/open_webui/static/favicon.png" ]; then
        cp "static/static/Bonsai_Logo_ohne research.png" "backend/open_webui/static/favicon.png"
    fi
    if [ -f "backend/open_webui/static/logo.png" ]; then
        cp "static/static/Bonsai_Logo_ohne research.png" "backend/open_webui/static/logo.png"
    fi
fi

echo "✅ bonsAI Chat branding restored successfully!"
echo "🔄 You may need to restart the dev server to see all changes."
