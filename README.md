# ArcheOS

Distribution Linux custom basee sur Debian Bookworm avec un look Windows 11 dark et accent orange.

## Fonctionnalites

- **KDE Plasma** avec theme sombre et accent orange (#FF6D00)
- **Installation automatique** : seules questions = langue, clavier, nom d'utilisateur + mot de passe
- **Boot splash** : logo ArcheOS au demarrage (Plymouth)
- **Barre des taches centree** style Windows 11
- **Apps incluses** : Google Chrome, Firefox, LibreOffice, Dolphin, Konsole, Mousepad, Galculator
- **VMware ready** : open-vm-tools pre-installe
- **Parametres verrouilles** : fond d'ecran et hostname non modifiables par l'utilisateur

## Build

Le build se fait automatiquement via GitHub Actions. Chaque push sur `main` genere un ISO telechareable dans les Artifacts.

## Test sur VMware

1. Ouvrir VMware Workstation Player
2. Creer une VM : Linux > Debian 12 64-bit
3. RAM : 4 Go, CPU : 2, Disque : 20 Go
4. Pointer vers `arche-os.iso`
5. Demarrer -> l'installation commence automatiquement

## Personnalisation

- **Packages** : editer `config/package-lists/*.list.chroot`
- **Wallpaper** : remplacer `config/includes.chroot/usr/share/backgrounds/arche/default-wallpaper.png`
- **Theme** : editer `config/hooks/normal/0400-configure-theme.hook.chroot`
- **Preseed** : editer `config/includes.installer/preseed.cfg`
- **Restrictions** : editer `config/hooks/normal/0700-lock-settings.hook.chroot`

Apres modification : push sur main -> GitHub Actions rebuild automatiquement.
