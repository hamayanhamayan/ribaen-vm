#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

apt update

# check if flatpak is installed
if command -v flatpak &> /dev/null; then
    echo "[*] flatpak is already installed."
else
    echo "[*] flatpak is not installed."
    echo "[ ] Installing flatpak..."
    apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    read -p "[*] Do you want to reboot now? (y/n): " choice
    if [ "$choice" == "y" ]; then
        echo "Rebooting..."
        reboot now
    else
        echo "Please rebooting before proceeding."
        exit 1
    fi
fi

#
# Jadx: https://github.com/skylot/jadx
# memo: flathub微妙かもな…
#

flatpak install -y flathub com.github.skylot.jadx