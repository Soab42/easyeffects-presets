#!/usr/bin/env bash
# This script automatically detects the EasyEffects presets directory and installs all presets.
# Recent EasyEffects versions load presets from the XDG data dir; older versions used the config dir.
# We install to both so the presets show up regardless of version.

GIT_REPOSITORY="https://github.com/Soab42/easyeffects-presets"
BRANCH="main"

check_installation() {
    if command -v flatpak &>/dev/null && flatpak list | grep -q "com.github.wwmm.easyeffects"; then
        FLATPAK_BASE="$HOME/.var/app/com.github.wwmm.easyeffects"
        PRESETS_DIRECTORIES=(
            "$FLATPAK_BASE/data/easyeffects"
            "$FLATPAK_BASE/config/easyeffects"
        )
    elif which easyeffects >/dev/null 2>&1; then
        DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
        CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
        PRESETS_DIRECTORIES=(
            "$DATA_DIR/easyeffects"
            "$CONFIG_DIR/easyeffects"
        )
    else
        echo "Error! Couldn't find EasyEffects presets directory!"
        echo "Make sure EasyEffects is installed (system package or Flatpak)."
        exit 1
    fi
    for dir in "${PRESETS_DIRECTORIES[@]}"; do
        mkdir -p "$dir/output"
    done
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
    for dir in "${PRESETS_DIRECTORIES[@]}"; do
        echo "Installing $COUNT presets into $dir/output/ ..."
        cp "$EXTRACTED_DIR/json/"*.json "$dir/output/"
    done

    rm -rf "$TMP_DIR"
    echo "Done! $COUNT presets installed to:"
    for dir in "${PRESETS_DIRECTORIES[@]}"; do
        echo "  - $dir/output/"
    done
    echo "Restart EasyEffects (or reload its preset list) to see them."
}

check_installation
install_presets
