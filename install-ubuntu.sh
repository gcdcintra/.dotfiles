#!/usr/bin/env zsh

DOTFILES=$HOME/.dotfiles/dotfiles

STOW_FOLDERS="bin,i3,nvim,tmux,ubuntu,zsh"

# Initialize submodules
git submodule update --init --recursive --remote
pushd dotfiles
pushd projects
git checkout master
popd
pushd personal
git checkout main
popd
pushd personal
git checkout main
popd
popd

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

# Install lua-language-server
mkdir -p $HOME/.dotfiles/lua-language-server
pushd $HOME/.dotfiles/lua-language-server
wget https://github.com/sumneko/lua-language-server/releases/download/3.4.2/lua-language-server-3.4.2-linux-x64.tar.gz
tar -xf lua-language-server-3.4.2-linux-x64.tar.gz
rm lua-language-server-3.4.2-linux-x64.tar.gz
popd

# Clone yocto repositories
mkdir $HOME/work/yocto
pushd $HOME/work/yocto

git clone git://git.yoctoproject.org/poky
pushd poky
git checkout kirkstone
popd

git clone git@github.com:openembedded/meta-openembedded.git
pushd meta-openembedded
git checkout kirkstone
popd

git clone git@github.com:agherzan/meta-raspberrypi.git
pushd meta-raspberrypi
git checkout kirkstone
popd

git clone git@github.com:linux-sunxi/meta-sunxi.git
pushd meta-sunxi
git checkout kirkstone
popd

git clone git@bitbucket.org:veltec/meta-vtalks.git
pushd meta-vtalks
git checkout kirkstone
popd

mkdir builds
popd

