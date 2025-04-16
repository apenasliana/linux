# OpenRGB

    OpenRBG is software that controls RGB hardware 
    This folder contains ProfileBackups and some configuration files

---

openRgb:
yay (openrgb)[https://aur.archlinux.org/packages/openrgb]


---

(https://www.reddit.com/r/OpenRGB/comments/np4jkd/auto_apply_theme/)

If you are on Linux, the best way is to run it as a Systemd USER service. If you try to run it as a normal Systemd service it won't have access to many of the devices on startup (I've tried to fix but I gave up after almost an entire week wasted on that). This means, however, that it won't run until you are logged in.

Here is my service file (~/.config/systemd/user/openrgb.service):

[Unit]
Description=OpenRGB control
[Service]
Type=simple
ExecStart=openrgb -p Personal.orp
RemainAfterExit=yes
[Install]
WantedBy=default.target

The -p flag allows you to load a specific profile (here Personal.orp, stored on the default config folder that you can find in the Gitlab Wiki)

After creating the openrgb.service file, run

systemctl --user enable openrgb.service && systemctl --user start openrgb.service