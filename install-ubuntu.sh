#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles/dotfiles

STOW_FOLDERS="bin,i3,nvim,tmux,ubuntu,zsh"

# Initialize submodules
git submodule update --init --recursive

# Stow dotfiles
pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow --restow $folder
done
stow --adopt --restow projects -t $HOME/projects
stow --adopt --restow personal -t $HOME/personal
stow --adopt --restow work -t $HOME/work
popd

# Install lua-language-server
mkdir -p $HOME/.dotfiles/lua-language-server
pushd $HOME/.dotfiles/lua-language-server
wget https://github.com/sumneko/lua-language-server/releases/download/3.4.2/lua-language-server-3.4.2-linux-x64.tar.gz
tar -xf lua-language-server-3.4.2-linux-x64.tar.gz
rm lua-language-server-3.4.2-linux-x64.tar.gz
popd
