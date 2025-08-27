#
# ~/.bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# keybinds
NC='\033[00m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PURPLE='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'

# cds
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# vim
alias vim='nvim'
# la commands
alias ls='eza -la --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias lt='eza -aT --color=always --group-directories-first'
# paru
alias update='paru -Syu'
alias paru='paru --bottomup'
# rclone
alias obsidian-upload='rclone sync /home/gabri/Documents/ObsidianVault gdrive:ObsidianVault --delete-after -v'
alias obsidian-download='rclone sync gdrive:ObsidianVault /home/gabri/Documents/ObsidianVault --delete-after -v'
# theming
alias gtk-theme='gsettings set org.gnome.desktop.interface gtk-theme'
alias icon-theme='gsettings set org.gnome.desktop.interface icon-theme'
# wallpapers
alias wallpaper="swww img"
alias wallpaper-ti='swww img /home/gabri/.wallpapers/music-wallpapers/ti.png'
alias wallpaper-redhood='swww img /home/gabri/.wallpapers/comic-wallpapers/redhood.png'
alias wallpaper-nightfall='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-nightfall.jpeg'
alias wallpaper-temple='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-temple.png'
alias wallpaper-scifi='swww img /home/gabri/.wallpapers/pixel-wallpapers/scifi.jpg'
alias wallpaper-planet='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-planet.png'
# config shortcuts
alias config='codium /home/gabri/.config/hypr/hyprland.conf'
alias bashrc='codium /home/gabri/.bashrc'
alias keyboard-widget='codium /home/gabri/HyprPanel/modules/menus/notifications/controls/index.ts'
# lol
alias google='{read -r arr; browser "https://google.com/search?q=${arr}";} <<<'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
# git
alias ga='git add .'
alias gc='git commit -m "Automated commit"'
alias gp='git push origin main'
alias gcap='git add . && git commit -m "Automated commit" && git push origin main'


PS1='[\u@\h \W]\$ '

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

eval "$(thefuck --alias)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
# Created by `pipx` on 2025-08-09 20:55:18
export PATH="$PATH:/home/gabri/.local/bin"
eval "$(pyenv init -)"
