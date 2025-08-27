# ~/.zshrc
# Executed by Zsh for interactive shells.

# If not running interactively, don't do anything
[[ -o interactive ]] || return 0

# --- Zsh Configuration (from install scripts) ---
# History settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Key-bindings (e for emacs mode)
bindkey -e

# Zsh completion system
autoload -Uz compinit
compinit

# --- Color Variables ---
# These are standard ANSI escape codes and work fine in Zsh.
NC='\033[00m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PURPLE='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'


# --- Aliases ---
# All your aliases are compatible with Zsh.

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Editors
alias vim='nvim'

# eza (ls replacement)
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

# Theming
alias gtk-theme='gsettings set org.gnome.desktop.interface gtk-theme'
alias icon-theme='gsettings set org.gnome.desktop.interface icon-theme'

# Wallpapers
alias wallpaper="swww img"
alias wallpaper-ti='swww img /home/gabri/.wallpapers/music-wallpapers/ti.png'
alias wallpaper-redhood='swww img /home/gabri/.wallpapers/comic-wallpapers/redhood.png'
alias wallpaper-nightfall='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-nightfall.jpeg'
alias wallpaper-temple='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-temple.png'
alias wallpaper-scifi='swww img /home/gabri/.wallpapers/pixel-wallpapers/scifi.jpg'
alias wallpaper-planet='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-planet.png'

# Config shortcuts
alias config='codium /home/gabri/.config/hypr/hyprland.conf'
alias bashrc='codium /home/gabri/.zshrc\\\\'
alias zshrc='codium /home/gabri/.zshrc' # Added a new alias for your zshrc
alias starship-config='codium ~/.config/starship.toml'
alias keyboard-widget='codium /home/gabri/HyprPanel/modules/menus/notifications/controls/index.ts'

# Misc
alias google='{read -r arr; browser "https://google.com/search?q=${arr}";} <<<'
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Git
alias ga='git add .'
alias gc='git commit -m "Automated commit"'
alias gp='git push origin main'
alias gcap='git add . && git commit -m "Automated commit" && git push origin main'


# --- Environment Variables & Tools ---

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# thefuck
eval "$(thefuck --alias)"

# pyenv
# This is the recommended setup for Zsh to avoid duplicate PATH entries.
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipx
# Created by `pipx` on 2025-08-09 20:55:18
export PATH="$PATH:/home/gabri/.local/bin"


# --- Starship Prompt ---
# This must be at the end of the file to ensure it runs after all other settings.
eval "$(starship init zsh)"