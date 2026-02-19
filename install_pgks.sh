#!/bin/bash

# List of packages to install
packages=(
  # Terminal
  tmux
  lazygit
  lazydocker
  neovim
  fish

  # Utilities
  unzip
  fd
  ripgrep
  fzf
  lsd
  # dotnet-host
  # dotnet-runtime
  # dotnet-sdk

  # Desktop pkgs #

  # Fonts
  ttf-jetbrains-mono-nerd

  # Desktop Programs
  ghostty
  bitwarden
  btop
  ktorrent
  syncthing
  zerotier-one
  obsidian
  eog
  qalculate-gtk

  timeshift
  xhost # timeshift dependency

  # Theme
  materia-gtk-theme
  bibata-cursor-theme-bin
  # Papirus Icon Set
  # wget -qO- https://git.io/papirus-icon-theme-install | sh
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

