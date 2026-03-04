# SylonOS

Distribution Linux custom basee sur Debian Bookworm avec un look Windows 11 dark et accent orange.

## Fonctionnalites

- **KDE Plasma** avec theme sombre et accent orange (#FF6D00)
- **Installation automatique** : seules questions = langue, clavier, nom d'utilisateur + mot de passe
- **Boot splash** : logo SylonOS au demarrage (Plymouth)
- **Barre des taches centree** style Windows 11
- **Apps incluses** : Firefox, Dolphin, Konsole, Spectacle, Ark
- **VMware ready** : open-vm-tools pre-installe

## Prerequis

- Windows 11 avec WSL2
- Debian dans WSL2 : `wsl --install -d Debian`
- VMware Workstation Player (pour tester l'ISO)

## Installation (dans WSL2 Debian)

```bash
# 1. Installer les outils
sudo apt update && sudo apt install -y live-build make git imagemagick

# 2. Cloner le projet DANS le filesystem WSL (pas /mnt/c/)
cd ~
git clone <votre-repo> os-house
cd os-house

# 3. Generer les assets graphiques (logo, wallpaper, splash)
chmod +x generate-assets.sh
./generate-assets.sh

# 4. Rendre les scripts executables
chmod +x auto/config auto/build auto/clean
chmod +x config/hooks/normal/*.hook.chroot

# 5. Build de l'ISO
make all

# 6. Copier l'ISO sur le bureau Windows
make copy-iso
```

## Test sur VMware

1. Ouvrir VMware Workstation Player
2. Creer une VM : Linux > Debian 12 64-bit
3. RAM : 4 Go, CPU : 2, Disque : 20 Go
4. Pointer vers `sylon-os.iso`
5. Demarrer → l'installation commence automatiquement

## Personnalisation

- **Packages** : editer `config/package-lists/*.list.chroot`
- **Wallpaper** : remplacer `config/includes.chroot/usr/share/backgrounds/sylon/default-wallpaper.png`
- **Theme** : editer `config/hooks/normal/0400-configure-theme.hook.chroot`
- **Preseed** : editer `config/includes.installer/preseed.cfg`

Apres modification : `make clean && make all`
