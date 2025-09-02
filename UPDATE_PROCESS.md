# bonsAI Chat - Update Prozess

Dieses Dokument beschreibt, wie Updates vom ursprünglichen Open WebUI Repository übernommen werden, während das bonsAI Chat Branding erhalten bleibt.

## Setup (einmalig bereits erledigt)

```bash
# Upstream Repository hinzufügen
git remote add upstream https://github.com/open-webui/open-webui.git
```

## Update-Prozess

### 1. Aktuelle Änderungen committen

```bash
# Alle bonsAI Chat Anpassungen committen
git add .
git commit -m "feat: bonsAI Chat branding and customizations"
git push origin main
```

### 2. Updates vom Upstream holen

```bash
# Neueste Änderungen von Open WebUI holen
git fetch upstream

# Aktuellen Branch anzeigen
git branch

# Merge vom upstream/main
git merge upstream/main
```

### 3. Merge-Konflikte lösen (falls vorhanden)

Falls es Konflikte gibt, diese manuell lösen:
- Bei Branding-Dateien: Unsere bonsAI Chat Version behalten
- Bei Funktionalität: Open WebUI Updates übernehmen
- Bei Zweifel: Beide Versionen prüfen und entscheiden

### 4. Branding wiederherstellen

Nach dem Merge das Branding-Skript ausführen:

**Windows (PowerShell):**
```powershell
.\scripts\restore-branding.ps1
```

**Linux/macOS:**
```bash
./scripts/restore-branding.sh
```

### 5. Testen und committen

```bash
# Änderungen testen
npm run dev

# Falls alles funktioniert, committen
git add .
git commit -m "chore: restore bonsAI Chat branding after upstream merge"
git push origin main
```

## Automatisierte Alternative

Für einen vollautomatischen Update-Prozess:

```bash
# update-with-branding.sh
#!/bin/bash
echo "🔄 Starting bonsAI Chat update process..."

# 1. Commit current changes
git add .
git commit -m "chore: save current state before update"

# 2. Fetch and merge upstream
git fetch upstream
git merge upstream/main

# 3. Restore branding
./scripts/restore-branding.sh

# 4. Commit branding changes
git add .
git commit -m "chore: restore bonsAI Chat branding after upstream merge"

echo "✅ Update complete! Test the application and push when ready."
```

## Wichtige Dateien für Branding

Diese Dateien enthalten unser Branding und sollten bei Updates überwacht werden:

- `package.json` - App Name
- `src/app.html` - Titel und Meta-Tags
- `static/opensearch.xml` - Suchkonfiguration
- `static/static/site.webmanifest` - Web App Manifest
- `static/static/favicon.*` - Alle Favicon-Dateien
- `src/routes/+layout.svelte` - Benachrichtigungen
- Alle Admin-Seiten in `src/routes/(app)/`
- Backend Error Messages in `backend/open_webui/routers/`

## Tipps

1. **Vor jedem Update:** Backup des aktuellen Zustands erstellen
2. **Nach Updates:** Gründlich testen, besonders UI-Elemente
3. **Bei größeren Änderungen:** Updates in einem separaten Branch testen
4. **Regelmäßig updaten:** Kleine, häufige Updates sind einfacher zu handhaben als große

## Troubleshooting

**Problem: Merge-Konflikte**
- Lösung: Manuell lösen, dabei bonsAI Chat Branding priorisieren

**Problem: Skript funktioniert nicht**
- Lösung: Manuell die Dateien in der Reihenfolge der Skript-Schritte bearbeiten

**Problem: Neue Branding-Stellen nach Update**
- Lösung: Neue Vorkommen von "Open WebUI" suchen und ersetzen
- `grep -r "Open WebUI" src/ backend/` ausführen
