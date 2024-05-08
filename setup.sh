#!/bin/zsh
set -e
setopt GLOB_DOTS

DOTS="$HOME/.dotfiles"
env BUN_INSTALL=/tmp/.bun curl -fsSL https://bun.sh/install | bash

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
/tmp/.bun/bun install && rm -rf /tmp/.bun
git checkout .zshrc
cd -

source ~/.zshrc
