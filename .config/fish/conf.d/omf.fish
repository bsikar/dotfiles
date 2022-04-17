# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set EDITOR "vim"

alias q="exit"
alias c="clear"
alias v="vim"
alias l="ls -lah"
alias cl="clear;ls"
alias pf="pfetch"
alias nf="neofetch"
alias poweroff="sudo poweroff"
alias cpy="xclip -selection clipboard"
alias poff="poweroff"
alias lol="lolcat"
alias y="yes"
alias x="startx"
alias tb="nc termbin.com 9999"

# CARGO - default
alias cr="cargo run"
alias crr="cargo run --release"
alias cb="cargo build"
alias cbr="cargo build --release"
alias cf="cargo fetch"
alias cn="cargo new"
# CARGO - other
alias ca="cargo add"
alias crm="cargo rm"
alias ce="cargo expand"
alias cfm="cargo fmt"

alias up="sudo apt update -y && sudo apt upgrade -y"

