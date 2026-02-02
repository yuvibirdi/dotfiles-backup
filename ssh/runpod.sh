#!/usr/bin/env bash
set -eo pipefail

echo "Setting up the project environment..."
apt update -y && apt upgrade -y
apt install -y fish neovim btop git curl vulkan-tools libegl1 libgl1 libglx0 libglvnd0 libgles2
cd ~/
git clone https://www.github.com/yuvibirdi/dotfiles-backup dotfiles --depth=1
cd dotfiles/ssh
if [ ! -d "/root/.config" ]; then
    mkdir /root/.config
fi
cp -rfv .config/* ~/.config/
cp -rfv ..files/.[!.]* ~/

echo "done setting up! enjoy"
