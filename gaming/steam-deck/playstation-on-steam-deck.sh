#!/bin/bash
# Tim H 2023
# Getting Playstation Plus PC running on Steam Deck
# This is just streaming from their remote servers, not from my PS4 or PS5

# https://www.polygon.com/guides/23546431/playstation-plus-cloud-streaming-app-steam-deck-install-protonup
# https://www.playstation.com/en-us/ps-plus/getting-started/#pc

# Download the necessary files
cd ~/Downloads || exit 1
wget --output-document="PlayStationPlus-Installer.exe" "https://download-psplus.playstation.com/downloads/psplus/pc/latest"
wget "https://raw.githubusercontent.com/legluondunet/MyLittleLutrisScripts/master/OBSOLETE%20NO%20MORE%20MAINTAINED/Playstation%20Now/msvcr120.dll.tar.xz"

# extract the extra DLL:
tar -xf msvcr120.dll.tar.xz

# make sure the destination directory exists
cd ~/.local/share/Steam/steamapps/compatdata || exit 2

# find the extract path - will be different on every Steam Deck
# MUST BE AN ABSOLUTE PATH, NOT RELATIVE PATH, CAN'T USE "."
EXTRACT_PATH=$(find ~/.local/share/Steam/steamapps/compatdata -type d -name 'PlayStationPlus' -path '*drive_c/Program Files (x86)*')

# copy the file
sudo cp ~/Downloads/msvcr120.dll "$EXTRACT_PATH/"

# verify the file is there and has the right permissions:
ls -lah "$EXTRACT_PATH/msvcr120.dll"

# Remove the unidater files
cd "$EXTRACT_PATH" || exit 3
mkdir -p backup
mv unidater.exe backup/
mv unidater.ini backup/

# get the whole path for copy and paste for Steam Deck GUI
echo "$EXTRACT_PATH/pspluslauncher.exe" > ~/Desktop/pslauncherpath.txt
