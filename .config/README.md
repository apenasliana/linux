# lily's .configs


---

# fresh install 101

---

Don't forget those when doing a fresh install

---

## i3 and some core packages

- xorg-server xorg-xinit xorg-apps nvidia
- i3 dmenu i3status i3blo cks xfce4-terminal 
- firefox git picom thunar
- alsa-utils nano nitrogen leafpad xcompmgr
- gnome-keyring polybar
- xdg-user-dirs

  $ xdg-user-dirs-update $ 

- neofetch htop ranger

---


cp /etc/X11/xinit/xinitrc ~/.xinitrc


> with that, u are prob good to go! 
> Remember to check -> ".misc-guides" and the next utils section 

---

# utils

## utils

Yay: 
    sudo pacman -S git go
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

### steam:
enable multilib repository,
uncomment the [multilib] section in /etc/pacman.conf
    
    [multilib]
    Include = /etc/pacman.d/mirrorlist


### Vscode:

---

# extra configs in ".misc-guides"

-> fonts
-> wine/proton
-> openRgb
-> random apps