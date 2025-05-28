#!/bin/zsh
set -e
setopt GLOB_DOTS

DOTS="$HOME/.dotfiles"
curl -fsSL https://bun.sh/install | bash

ln -vsf $DOTS/.zshrc ~/
ln -vsf $DOTS/.gitconfig ~/
ln -vsf $DOTS/.wezterm.lua ~/
ln -vsf $DOTS/.tmux.conf ~/

mkdir ~/bin &>/dev/null || true

for p in $DOTS/.config/*; do
	ln -vsf "${p}" ~/.config/
done

cd $DOTS
git pull --recurse-submodules
git submodule update --init --force
git submodule foreach --recursive git main
~/.bun/bun install
git checkout .zshrc
cd -

source ~/.zshrc
