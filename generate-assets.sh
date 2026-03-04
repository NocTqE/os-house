#!/bin/bash
# =============================================================================
# ArcheOS - Generateur d'assets graphiques
# A executer dans WSL2 ou GitHub Actions
# =============================================================================

set -e

echo ">>> Generation des assets ArcheOS..."

# Installer imagemagick si necessaire
if ! command -v convert &>/dev/null; then
    echo "Installation d'ImageMagick..."
    sudo apt install -y imagemagick
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Logo Plymouth (texte "ArcheOS" blanc sur fond transparent) ---
PLYMOUTH_DIR="$SCRIPT_DIR/config/includes.chroot/usr/share/plymouth/themes/arche"
mkdir -p "$PLYMOUTH_DIR"

convert -size 400x120 xc:transparent \
    -font "DejaVu-Sans-Bold" -pointsize 64 \
    -fill white -gravity center \
    -annotate 0 "ArcheOS" \
    "$PLYMOUTH_DIR/logo.png"
echo "  [OK] Logo Plymouth genere"

# --- Dot pour l'animation Plymouth (cercle orange) ---
convert -size 16x16 xc:transparent \
    -fill "#FF6D00" \
    -draw "circle 8,8 8,1" \
    "$PLYMOUTH_DIR/dot.png"
echo "  [OK] Dot Plymouth genere"

# --- Wallpaper : deja inclus dans le repo (fond-arche.jpg) ---
WALLPAPER_DIR="$SCRIPT_DIR/config/includes.chroot/usr/share/backgrounds/arche"
mkdir -p "$WALLPAPER_DIR"
if [ ! -f "$WALLPAPER_DIR/default-wallpaper.jpg" ]; then
    echo "  [WARN] Wallpaper manquant. Genere un placeholder..."
    convert -size 1920x1080 xc:"#1a1a2e" \
        -font "DejaVu-Sans-Bold" -pointsize 48 \
        -fill white -gravity center \
        -annotate 0 "ArcheOS" \
        "$WALLPAPER_DIR/default-wallpaper.jpg"
else
    echo "  [OK] Wallpaper deja present"
fi

# --- Splash isolinux (640x480, ecran de boot du CD) ---
ISOLINUX_DIR="$SCRIPT_DIR/config/includes.binary/isolinux"
mkdir -p "$ISOLINUX_DIR"

convert -size 640x480 xc:"#0f0f1a" \
    -font "DejaVu-Sans-Bold" -pointsize 36 \
    -fill "#FF6D00" -gravity center \
    -annotate +0-40 "ArcheOS" \
    -font "DejaVu-Sans" -pointsize 16 \
    -fill "#888888" \
    -annotate +0+20 "Appuyez sur Entree pour installer" \
    "$ISOLINUX_DIR/splash.png"
echo "  [OK] Splash isolinux genere"

echo ""
echo ">>> Assets generes avec succes !"
