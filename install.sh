#!/usr/bin/env bash


cat ~/work/bashscript/launch/aliases.sh >> ~/.dotfiles/aliases.sh

mkdir -p ~/.local/share/bin/apps
mkdir -p ~/.local/share/lib/ezbash

cp -R ~/work/bashscript/launch/ezbashrun.sh ~/.local/share/bin
cp -R ~/work/bashscript/apps/*   ~/.local/share/bin/apps

cp -R ~/work/bashscript/lib/*   ~/.local/share/lib/ezbash


