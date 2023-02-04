#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias desenho="xinput set-prop 17 \"Device Enabled\" 0 && xsetwacom set \"Wacom BambooPT 2FG 4x5 Pen stylus\" MapToOutput 1920x1080+0+0 && xsetwacom set \"Wacom BambooPT 2FG 4x5 Pen stylus\" PressureCurve 5 0 100 95"