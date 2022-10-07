# dotfiles
some of my linux config files

## dependencies
### run all commands as user except for nala and apt-get
- nala
	- apt-get update && apt-get install nala
- rust
	- nala install clang curl
	- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
- i3
	- nala install i3
- jetbrainsmono
    - nala install fonts-jetbrains-mono
- nodejs
    - nala install nodejs

## packages
- i3status-rust
	- nala install librust-libdbus-sys-dev libssl-dev librust-libsensors-sys-dev
	- cargo install i3status-rs
- alacritty
	- apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
	- cargo install alacritty
- dunst
	- should already be installed
	- nala install dunst
- picom
	- nala install picom
- dmenu
	- should already be installed
	- nala install suckless-tools
- fish/OMF
	- nala install fish
	- curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	- chsh -s $(which fish)
- neovim
	- nala install neovim
- ranger
	- nala install ranger python3-pip libx11-dev libxext-dev
	- pip3 install ueberzug

## Utils
- exa
    - nala install exa
- rg
    - nala install ripgrep
- bat (batcat)
    - nala install bat
- fd (fdfind)
    - nala install fd-find
- procs
    - cargo install procs
- ncdu
    - nala install ncdu

![screenshot](https://user-images.githubusercontent.com/65072072/178594963-1c37d563-fa2b-446a-a7bd-97e95d6f418c.png)
