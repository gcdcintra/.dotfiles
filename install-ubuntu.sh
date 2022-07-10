#!/usr/bin/env zsh
#
if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="bin,i3,nvim,tmux,ubuntu,zsh"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install-common
