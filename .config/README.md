# diretorio de .config's

## .config_files

    This folder contains some xinit and bash configurations

## misc

    This folder contains some misc files (wallpapers,...)

## i3

    i3 main configuration files

## i3status

    i3 bar/status configuration files

## .mplayer

    mplayer configuration file

## OpenRGB

    OpenRBG is software that controls my keyboard color
    This folder contains ProfileBackups and some configuration files

---

# fresh install 101

---

Don't forget this applications when formatting

---

## i3 and some core packages

- xorg-server xorg-xinit xorg-apps nvidia
- i3-gaps dmenu i3status i3blocks xfce4-terminal firefox git picom thunar
- alsa-utils nano nitrogen leafpad xcompmgr
- gnome-keyring polybar
- xdg-user-dirs

  $ xdg-user-dirs-update $ 

---

- neofetch htop ranger



## utils

Yay: 

    sudo pacman -S git go
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

steam:
    enable multilib repository,
    uncomment the [multilib] section in /etc/pacman.conf
    
    [multilib]
    Include = /etc/pacman.d/mirrorlist

Vscode:

    yay visual-studio-code-bin[https://aur.archlinux.org/packages/visual-studio-code-bin]

Wine stuff: https://github.com/lutris/docs/blob/master/WineDependencies.md

first enable multilib repository, uncomment the [multilib] section in /etc/pacman.conf
sudo pacman -S winetricks
sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

Proton helpers

yay dxvk-bin
yay gamemode 


openRgb:
yay (openrgb)[https://aur.archlinux.org/packages/openrgb]
go the README.md on OpenRGB folder for configuration.


Misc:
yay google-chrome
discord telegram-desktop
mplayer
yay obs-studio-browser 
yay deepin-screen-recorder (https://archlinux.org/packages/community/x86_64/deepin-screen-recorder/)
- rustdesk


cp /etc/X11/xinit/xinitrc ~/.xinitrc




# FONTS:
PACMAN: ttf-roboto noto-fonts ttf-baekmuk noto-fonts-emoji gnu-free-fonts ttf-arphic-uming ttf-indic-otf


AUR: ttf-ms-fonts ttf-mplus-git otf-openmoji

| Font Name       | Pacman       | AUR                | Description                                                                                                                                       |
| --------------- | ------------ | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Roboto          | (ttf-roboto) | X                  | Default font for newer Android versions where it is complemented by Noto fonts for languages not supported like CJK                               |
| Noto fonts      | (noto-fonts) | X                  | Google font family with full Unicode coverage if installed with its emoji and CJK optional dependencies                                           |
| Microsoft fonts | X            | (ttf-ms-fonts^AUR) | Andalé Mono, Courier New, Arial, Arial Black, Comic Sans, Impact, Lucida Sans, Microsoft Sans Serif, Trebuchet, Verdana, Georgia, Times New Roman |


### Localization
| Font Name             | Pacman      | AUR              | Description                                                                                                                 |
| --------------------- | ----------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Localization/Japanese | X           | ttf-mplus-gitAUR | Modern Gothic style Japanese outline fonts. It includes all of Japanese Hiragana/Katakana, Basic Latin, Latin-1 Supplement, | Latin Extended-A, IPA Extensions and most of Japanese Kanji, Greek, Cyrillic, Vietnamese with 7 weights (proportional) or 5 weights (monospace). |
| Localization/Korean   | ttf-baekmuk | X                | Collection of Korean TrueType fonts                                                                                         |

### Emojis
| Font Name  | Pacman                                              | AUR             | Description                                                                                                                                                      |
| ---------- | --------------------------------------------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Noto-Emoji | noto-fonts-emoji                                    | x               | Google's open-source Emoji 14.0.                                                                                                                                 |
| Emoji      | X                                                   | otf-openmojiAUR | German University of Design in Schwäbisch Gmünd open-source Emoji 13.0.                                                                                          |
| Kaomoji    | gnu-free-fonts, ttf-arphic-uming, and ttf-indic-otf | X               | Kaomoji are sometimes referred to as "Japanese emoticons" and are composed of characters from various character sets, including CJK and Indic fonts. For example |