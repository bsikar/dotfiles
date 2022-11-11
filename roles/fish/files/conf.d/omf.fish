# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH
set EDITOR 'vim'

alias wm='echo -e "Xephyr -br -ac -noreset -screen 800x600 :1\nDISPLAY=:1"'
alias c='clear'
alias l='ls -lah'
alias cl='clear; ls'
alias storage='sudo ncdu -x /'
alias nf='neofetch'
alias cpy='xclip -selection clipboard'

function stop --description "stop <program name>"
	set i (count $argv)
	if test $i -gt 0
		for i in (seq $i)
			while killall $argv[$i]
			end
		end
	end
end

# alternatives
alias vim='nvim'
alias find='fdfind'
alias ls='exa'
alias grep='rg'
alias cat='batcat'
alias pd='procs'
alias du='ncdu'

# CARGO - default
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias cbr='cargo build --release'
alias cf='cargo fetch'
alias cn='cargo new'
# CARGO - other
alias ca='cargo add'
alias crm='cargo rm'
alias ce='cargo expand'
alias cfm='cargo fmt'

