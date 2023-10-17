#!/bin/bash
# Tim H 2023
# Getting PS Remote Play running on Steam Deck
# https://dashgamer.com/how-to-get-playstation-remote-play-on-steam-deck/

sudo pacman -S --needed base-devel

# chiaki is available via Snap, not pacman
cd "$HOME" || exit 1
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket

sudo ln -s /var/lib/snapd/snap /snap

sudo snap install chiaki

# pacman --sync --search chiaki

#PSN_USERNAME="fart"
#echo -n "$PSN_USERNAME" | base64 -e

# fXxBqwTmiG0=