#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles/dotfiles
STOW_FOLDERS="bin,i3,nvim,tmux,ubuntu,zsh"

# Install Yocto host packages
sudo apt install \
	gawk wget git diffstat unzip texinfo gcc build-essential \
	chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
	debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
	libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd \
	liblz4-tool

# Install lua-language-server
mkdir -p $HOME/.dotfiles/lua-language-server
pushd $HOME/.dotfiles/lua-language-server
wget https://github.com/sumneko/lua-language-server/releases/download/3.4.2/lua-language-server-3.4.2-linux-x64.tar.gz
tar -xf lua-language-server-3.4.2-linux-x64.tar.gz
rm lua-language-server-3.4.2-linux-x64.tar.gz
popd

# Update submodules
git submodule update --remote --merge

# Stow dotfiles
pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow --restow $folder -t $HOME
done
stow --adopt --restow projects -t $HOME/projects
stow --adopt --restow personal -t $HOME/personal
stow --adopt --restow work -t $HOME/work
popd

