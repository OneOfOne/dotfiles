#!/bin/zsh
set -e
setopt GLOB_DOTS

DOTS="$HOME/.dotfiles"
git --git-dir=$DOTS/.git --work-tree=$DOTS submodule update --init --force

ln -vsf $DOTS/.zshrc ~/.zshrc
ln -vsf $DOTS/.gitconfig ~/.gitconfig
#ln -vsf $DOTS/.eslintrc.js ~/.eslintrc.js

mkdir ~/bin &>/dev/null
ln -vsf $DOTS/bin/* ~/bin/

for p in $DOTS/.config/*; do 
	ln -sfv "${p}" ~/.config/
done

