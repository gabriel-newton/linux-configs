#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -a --color=auto'
alias paru='paru --bottomup'
alias grep='grep --color=auto'
alias gtk-theme='gsettings set org.gnome.desktop.interface gtk-theme'
alias icon-theme='gsettings set org.gnome.desktop.interface icon-theme'
alias obsidian-upload='rclone sync /home/gabri/Documents/ObsidianVault gdrive:ObsidianVault --delete-after'
alias obsidian-download='rclone sync gdrive:ObsidianVault /home/gabri/Documents/ObsidianVault --delete-after'

alias wallpaper-ti='swww img /home/gabri/.wallpapers/music-wallpapers/ti.png'
alias wallpaper-redhood='swww img /home/gabri/.wallpapers/comic-wallpapers/redhood.png'
alias wallpaper-nightfall='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-nightfall.jpeg'
alias wallpaper-temple='swww img /home/gabri/.wallpapers/pixel-wallpapers/pixel-temple.png'


PS1='[\u@\h \W]\$ '

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
