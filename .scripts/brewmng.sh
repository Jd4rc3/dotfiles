#!/bin/env bash

function update-packages()
{
	brew leaves > ~/.dotfiles/brew-packages
}

function install-packages()
{
	xargs brew install < ~/.dotfiles/brew-packages
}

case $1 in
	update) update-packages ;;
	install) install-packages ;;
esac
