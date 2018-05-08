#!/bin/zsh
DOTS="$HOME/.dotfiles"

ln -vsf $DOTS/.zshrc ~/.zshrc
ln -vsf $DOTS/.gitconfig ~/.gitconfig
ln -vsf $DOTS/.eslintrc.js ~/.eslintrc.js

mkdir ~/bin &>/dev/null
ln -vsf $DOTS/bin/* ~/bin/

mkdir ~/.config/nvim
ln -vsf $DOTS/.config/nvim ~/.config/
