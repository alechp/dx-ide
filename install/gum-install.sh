#!/bin/bash

echo "Which package manager would you like to use to install gum (https://github.com/charmbracelet/gum)?"
echo "(1) brew\n(2) pacman\n(3) nix\n(4) debian/ubuntu\n(5) fedora"
read pkgmgr

case $pkgmgr in
  
  1)
    echo "Installing gum via brew"
    brew install gum

    ;;

  2)
    echo "Installing gum via pacman"
    pacman -S gum
    ;;

  3)
    echo "Installing gum via nix-env"
    nix-env -iA nixpkgs.gum
    ;;

  4)
    echo "Installing gum via apt"
    echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install gum

    ;;

  5)
    echo "Installing gum via yum"
    echo '[charm]
    name=Charm
    baseurl=https://repo.charm.sh/yum/
    enabled=1
    gpgcheck=0' | sudo tee /etc/yum.repos.d/charm.repo
    sudo yum install gum
    ;;

esac

# ========================================
# Gum install commands
# -- https://github.com/charmbracelet/gum
# ========================================

# # macOS or Linux
# ========================================
# brew install gum

# # Arch Linux (btw)
# ========================================
# pacman -S gum

# # Nix
# ========================================
# nix-env -iA nixpkgs.gum

# # Debian/Ubuntu
# ========================================
# echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
# sudo apt update && sudo apt install gum

# # Fedora
# ========================================
# echo '[charm]
# name=Charm
# baseurl=https://repo.charm.sh/yum/
# enabled=1
# gpgcheck=0' | sudo tee /etc/yum.repos.d/charm.repo
# sudo yum install gum
