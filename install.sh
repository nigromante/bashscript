#!/usr/bin/env bash

figlet "ezbash - install"

cat ~/work/bashscript/launch/aliases.sh >> ~/.dotfiles/aliases.sh

[[ -d "~/.local/share/bin/apps" ]]   && mkdir -p ~/.local/share/bin/apps
[[ -d "~/.local/share/lib/ezbash" ]] && mkdir -p ~/.local/share/lib/ezbash

cp -R ~/work/bashscript/launch/ezbashrun.sh ~/.local/share/bin
cp -R ~/work/bashscript/apps/*   ~/.local/share/bin/apps

cp -R ~/work/bashscript/lib/*   ~/.local/share/lib/ezbash


