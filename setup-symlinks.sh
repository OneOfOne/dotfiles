#!/bin/zsh
DOTS="$HOME/.dotfiles"

ln -vsf $DOTS/.zshrc ~/.zshrc
ln -vsf $DOTS/.gitconfig ~/.gitconfig
ln -vsf $DOTS/.eslintrc.js ~/.eslintrc.js

