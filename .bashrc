source ~/.local/share/blesh/ble.sh
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

source /usr/share/bash-completion/bash_completion
eval "$(starship init bash)"

alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias yayr="yay -Qq | fzf --multi --preview 'yay -Qii {1}' --preview-window=down:75% | xargs -ro yay -Rns"

export LIBVIRT_DEFAULT_URI="qemu:///system"

# Created by `pipx` on 2026-05-18 11:26:18
export PATH="$PATH:/home/khanal/.local/bin"
