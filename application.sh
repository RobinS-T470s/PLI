#!/bin/bash

#echo "Welcome to the Python-Library-Installer by Robin Schanbacher"

install_app() {
    local lib_name=$1
    local source_code_path=$2
    local target_dir="/usr/lib/python3/dist-packages/$lib_name"

    echo "Installing $lib_name from $source_code_path"

    # Überprüfen, ob die Quelldatei existiert
    if [ ! -f "$source_code_path" ]; then
        echo "Error: Source file $source_code_path does not exist."
        exit 1
    fi

    # Erstelle das Zielverzeichnis, falls es nicht existiert
    sudo mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

    # Kopiere die Datei __init__.py in das Zielverzeichnis
    sudo cp "$source_code_path" "$target_dir/__init__.py" || { echo "Failed to copy file"; exit 1; }
    echo "$lib_name has been installed successfully."
}

if [ $# -eq 2 ]; then
    install_app "$1" "$2"
else
    echo "Usage: pli <library_name> <source_code_path>"
fi
