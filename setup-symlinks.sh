#!/bin/zsh
set -e
setopt GLOB_DOTS

DOTS="$HOME/.dotfiles"
git --git-dir=$DOTS/.git --work-tree=$DOTS submodule update --init --force

ln -vsf $DOTS/.zshrc ~/
ln -vsf $DOTS/.gitconfig ~/
ln -vsf $DOTS/.wezterm.lua ~/
#ln -vsf $DOTS/.eslintrc.js ~/.eslintrc.js

mkdir ~/bin &>/dev/null

for p in $DOTS/.config/*; do
	ln -sfv "${p}" ~/.config/
done
