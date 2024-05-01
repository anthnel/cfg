#!/bin/zsh

# Update debian dependancies
if command -v apt &> /dev/null; then
  sudo apt update
  sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting vim httpie 
fi

if command -v git &> /dev/null; then
  # config git endline
  git config --global core.autocrlf input  
fi 

# install starship
curl -sS https://starship.rs/install.sh | sh -s -- -f

# install sdk man
curl -s "https://get.sdkman.io" | bash

# install fzf
zshplug="$HOME/.config/zsh_plugins"
fzfplugdir="$zshplug/fzf-zsh-plugin"

[[ ! -d ${zshplug} ]] && mkdir -p ${zshplug}
[[ ! -d ${fzfplugdir} ]] && git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${fzfplugdir}

# config
starship preset pure-preset -o ${HOME}/.config/starship.toml

source ~/.zshrc
