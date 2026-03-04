#!/bin/bash
# =============================================================================
# SylonOS - Generateur d'assets graphiques
# A executer dans WSL2 apres : sudo apt install -y imagemagick
# =============================================================================

set -e

echo ">>> Generation des assets SylonOS..."

# Installer imagemagick si necessaire
if ! command -v convert &>/dev/null; then
    echo "Installation d'ImageMagick..."
    sudo apt install -y imagemagick
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Logo Plymouth (texte "SylonOS" blanc sur fond transparent) ---
PLYMOUTH_DIR="$SCRIPT_DIR/config/includes.chroot/usr/share/plymouth/themes/sylon"
mkdir -p "$PLYMOUTH_DIR"

convert -size 400x120 xc:transparent \
    -font "DejaVu-Sans-Bold" -pointsize 64 \
    -fill white -gravity center \
    -annotate 0 "SylonOS" \
    "$PLYMOUTH_DIR/logo.png"
echo "  [OK] Logo Plymouth genere"

# --- Dot pour l'animation Plymouth (cercle orange) ---
convert -size 16x16 xc:transparent \
    -fill "#FF6D00" \
    -draw "circle 8,8 8,1" \
    "$PLYMOUTH_DIR/dot.png"
echo "  [OK] Dot Plymouth genere"

# --- Wallpaper (fond sombre avec accent orange) ---
WALLPAPER_DIR="$SCRIPT_DIR/config/includes.chroot/usr/share/backgrounds/sylon"
mkdir -p "$WALLPAPER_DIR"

# Fond noir-gris avec un halo orange subtil au centre
convert -size 1920x1080 \
    -define gradient:direction=diagonal \
    "gradient:#1a1a2e-#0f0f1a" \
    \( -size 1920x1080 xc:transparent \
       -fill "rgba(255,109,0,0.15)" \
       -draw "circle 960,540 960,200" \) \
    -composite \
    "$WALLPAPER_DIR/default-wallpaper.png"
echo "  [OK] Wallpaper genere"

# --- Splash isolinux (640x480, ecran de boot du CD) ---
ISOLINUX_DIR="$SCRIPT_DIR/config/includes.binary/isolinux"
mkdir -p "$ISOLINUX_DIR"

convert -size 640x480 xc:"#0f0f1a" \
    -font "DejaVu-Sans-Bold" -pointsize 36 \
    -fill "#FF6D00" -gravity center \
    -annotate +0-40 "SylonOS" \
    -font "DejaVu-Sans" -pointsize 16 \
    -fill "#888888" \
    -annotate +0+20 "Appuyez sur Entree pour installer" \
    "$ISOLINUX_DIR/splash.png"
echo "  [OK] Splash isolinux genere"

echo ""
echo ">>> Tous les assets ont ete generes avec succes !"
echo "    - Plymouth logo: $PLYMOUTH_DIR/logo.png"
echo "    - Plymouth dot:  $PLYMOUTH_DIR/dot.png"
echo "    - Wallpaper:     $WALLPAPER_DIR/default-wallpaper.png"
echo "    - Boot splash:   $ISOLINUX_DIR/splash.png"
