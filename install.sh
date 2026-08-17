#!/usr/bin/env bash
# This script automatically detects the EasyEffects presets directory and installs all presets.

GIT_REPOSITORY="https://github.com/Soab42/easyeffects-presets"
BRANCH="main"

check_installation() {
    if command -v flatpak &>/dev/null && flatpak list | grep -q "com.github.wwmm.easyeffects"; then
        PRESETS_DIRECTORY="$HOME/.var/app/com.github.wwmm.easyeffects/config/easyeffects"
    elif which easyeffects >/dev/null 2>&1; then
        PRESETS_DIRECTORY="$HOME/.config/easyeffects"
    else
        echo "Error! Couldn't find EasyEffects presets directory!"
        exit 1
    fi
    mkdir -p "$PRESETS_DIRECTORY/output"
}

install_presets() {
    TMP_DIR=$(mktemp -d)
    echo "Downloading presets from $GIT_REPOSITORY..."
    if ! curl -L "$GIT_REPOSITORY/archive/refs/heads/$BRANCH.tar.gz" -o "$TMP_DIR/repo.tar.gz" --fail --silent --show-error; then
        echo "Error: failed to download presets!"
        rm -rf "$TMP_DIR"
        exit 1
    fi

    echo "Extracting..."
    tar -xzf "$TMP_DIR/repo.tar.gz" -C "$TMP_DIR"

    EXTRACTED_DIR=$(find "$TMP_DIR" -maxdepth 1 -type d -name "easyeffects-presets-*" | head -n1)
    if [ -z "$EXTRACTED_DIR" ] || [ ! -d "$EXTRACTED_DIR/json" ]; then
        echo "Error: presets not found in downloaded archive!"
        rm -rf "$TMP_DIR"
        exit 1
    fi

    COUNT=$(find "$EXTRACTED_DIR/json" -maxdepth 1 -name "*.json" | wc -l)
    echo "Installing $COUNT presets into $PRESETS_DIRECTORY/output/ ..."
    cp "$EXTRACTED_DIR/json/"*.json "$PRESETS_DIRECTORY/output/"

    rm -rf "$TMP_DIR"
    echo "Done! $COUNT presets installed to $PRESETS_DIRECTORY/output/"
}

check_installation
install_presets
