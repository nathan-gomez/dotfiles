#!/bin/bash

# List of packages to install
packages=(
  # Terminal
  zsh
  oh-my-zsh-git
  tmux
  lazygit
  lazydocker
  neovim

  # Utilities
  unzip
  fd
  ripgrep
  nvm
  dotnet-host
  dotnet-runtime
  dotnet-sdk

  # Desktop pkgs #

  # Fonts
  ttf-jetbrains-mono-nerd

  # Other Programs
  alacritty
  bitwarden
  btop
  ktorrent
  syncthing
  zerotier-one
  obsidian
  visual-studio-code-bin

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

