#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run with sudo-rights!"
    exit 1
fi

# Dateipfade
benutzername="$USER"
befehl="/bin/pli"
source_file="src/application.sh"

if [ ! -f "$source_file" ]; then
    echo "$source_file not found!"
    exit 1
fi

# Setze Ausführungsrechte und kopiere das Skript in /bin
chmod +x "$source_file"
cp "$source_file" "$befehl"

# Regel zur Sudoers-Datei hinzufügen
echo "$benutzername ALL=(ALL) NOPASSWD: $befehl" | sudo EDITOR='tee -a' visudo

# Überprüfen, ob der Befehl erfolgreich hinzugefügt wurde
if sudo grep -q "$benutzername ALL=(ALL) NOPASSWD: $befehl" /etc/sudoers; then
    echo "Installed succesfully."
else
    echo "ERROR"
fi