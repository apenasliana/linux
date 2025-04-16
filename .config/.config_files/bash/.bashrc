#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$HOME/Documents/linux/.config/.config_files/bash/bashScripts:$PATH"

PRIMARY_MONITOR=DP-4
SECONDARY_MONITOR=DP-2
SECONDARY_RIGHT=DP-1
SECONDARY_LEFT=DP-3


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias audio="pactl load-module module-remap-source master=combined.monitor source_name=virtmic source_properties=device.description=Virtual_Microphone"
alias log="journalctl -r"
alias desenho="xinput set-prop 17 \"Device Enabled\" 0 && xsetwacom set \"Wacom BambooPT 2FG 4x5 Pen stylus\" MapToOutput 1920x1080+0+0 && xsetwacom set \"Wacom BambooPT 2FG 4x5 Pen stylus\" PressureCurve 5 0 100 95"



alias sourceConfigs='bash "$HOME/Documents/linux/.config/.config_files/bash/bashScripts/updateConfig.sh"'
alias sourceVideo='bash "$HOME/Documents/linux/.config/.config_files/bash/bashScripts/videoConfig.sh"'


# alias resaudio="systemctl --user restart pipewire pipewire-pulse wireplumber && systemctl --user daemon-reload"
# alias updatemtg="cd /home/miresuka/Games/MTGA/ && sh run.sh"

# alias vtuber="cd /home/miresuka/Games/OSF/OpenSeeFace/ && source env/bin/activate && python facetracker.py -c 2 -W 1280 -H 720 --discard-after 0 --scan-every 0 --no-3d-adapt 1 --max-feature-updates 900 -s 1 --port 20202"