#!/bin/zsh
DOTS="$HOME/.dotfiles"
git --git-dir=$DOTS/.git --work-tree=$DOTS submodule update --init --force

ln -vsf $DOTS/.zshrc ~/.zshrc
ln -vsf $DOTS/.gitconfig ~/.gitconfig
ln -vsf $DOTS/.eslintrc.js ~/.eslintrc.js

mkdir ~/bin &>/dev/null
ln -vsf $DOTS/bin/* ~/bin/

ln -vsf $DOTS/.config/nvim ~/.config/
ln -vsf $DOTS/.config/coc ~/.config/
