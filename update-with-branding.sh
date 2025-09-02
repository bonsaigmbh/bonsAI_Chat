#!/bin/bash
# bonsAI Chat - Automatischer Update-Prozess
# Dieses Skript führt ein Update vom Upstream durch und stellt das Branding wieder her

echo "🔄 Starting bonsAI Chat update process..."

# 1. Aktuelle Änderungen committen
echo "💾 Committing current changes..."
git add .
git commit -m "chore: save current state before update"

# 2. Upstream Updates holen
echo "📥 Fetching updates from Open WebUI upstream..."
git fetch upstream

# 3. Merge durchführen
echo "🔀 Merging upstream changes..."
if ! git merge upstream/main; then
    echo "⚠️ Merge conflicts detected! Please resolve manually and run:"
    echo "   git add ."
    echo "   git commit -m 'resolve merge conflicts'"
    echo "   ./scripts/restore-branding.sh"
    exit 1
fi

# 4. Branding wiederherstellen
echo "🌳 Restoring bonsAI Chat branding..."
./scripts/restore-branding.sh

# 5. Branding-Änderungen committen
echo "💾 Committing branding changes..."
git add .
git commit -m "chore: restore bonsAI Chat branding after upstream merge"

echo "✅ Update complete!"
echo "🔄 Please test the application thoroughly before pushing to origin."
echo "📤 When ready, push with: git push origin main"
