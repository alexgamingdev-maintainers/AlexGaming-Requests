#!/bin/bash
# 🛡️ Alex Gaming Automated PR Validator

echo "--------------------------------------------------"
echo "🚀 Starting Alex Gaming Gatekeeper Validation..."
echo "--------------------------------------------------"

# 1. Prüfen, ob Änderungen NUR im PR/ Ordner vorgenommen wurden
# Wir vergleichen den aktuellen Stand mit dem Haupt-Zweig (main)
FORBIDDEN_CHANGES=$(git diff --name-only origin/main...HEAD | grep -v "^PR/")

if [ -z "$FORBIDDEN_CHANGES" ]; then
    echo "✅ ÜBERPRÜFUNG ERFOLGREICH: Alle Änderungen liegen im PR/ Ordner."
else
    echo "❌ FEHLER: Unbefugte Änderungen außerhalb von PR/ erkannt!"
    echo "Folgende Dateien dürfen nicht von dir geändert werden:"
    echo "$FORBIDDEN_CHANGES"
    exit 1
fi

# 2. Prüfen, ob ein Unterordner in PR/ erstellt wurde
SUBFOLDER_COUNT=$(find PR/ -mindepth 1 -maxdepth 1 -type d | wc -l)
if [ "$SUBFOLDER_COUNT" -gt 0 ]; then
    echo "✅ ÜBERPRÜFUNG ERFOLGREICH: Unterordner-Struktur gefunden."
else
    echo "❌ FEHLER: Bitte erstelle einen eigenen Unterordner in PR/ für deinen Antrag."
    exit 1
fi

echo "--------------------------------------------------"
echo "🎉 VALIDIERUNG BESTANDEN: Bereit für Maintainer-Review."
echo "--------------------------------------------------"
