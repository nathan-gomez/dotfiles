#!/bin/bash

# List of packages to install
packages=(
  # Terminal
  alacritty
  zsh
  tmux
  lazygit
  lazydocker

  # Editors
  neovim
  visual-studio-code-bin

  # Utilities
  unzip
  fd
  ripgrep
  flatpak
  nvm
  dotnet-host
  dotnet-runtime
  dotnet-sdk

  # Fonts
  ttf-jetbrains-mono-nerd

  # Other Programs
  bitwarden
  btop
  ktorrent
  syncthing
  zerotier-one
  obsidian

  # i3
  polybar
  rofi
  rofi-greenclip
  nitrogen
)

# Update package database and upgrade system
echo "Updating system..."
yay -Syu --noconfirm

# Install packages
echo "Installing packages..."
for pkg in "${packages[@]}"; do
  if yay -Qi "$pkg" > /dev/null 2>&1; then
    echo "$pkg is already installed."
  else
    echo "Installing $pkg..."
    yay -S --needed --noconfirm "$pkg"
  fi
done

echo "All done."

