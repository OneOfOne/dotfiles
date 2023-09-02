#!/bin/zsh
set -e
setopt GLOB_DOTS

DOTS="$HOME/.dotfiles"
git --git-dir=$DOTS/.git --work-tree=$DOTS submodule update --init --force
git --git-dir=$DOTS/.git --work-tree=$DOTS git submodule foreach git pull origin master

ln -vsf $DOTS/.zshrc ~/
ln -vsf $DOTS/.gitconfig ~/
ln -vsf $DOTS/.wezterm.lua ~/


mkdir ~/bin &>/dev/null

for p in $DOTS/.config/*; do
	ln -sfv "${p}" ~/.config/
done
