#!/bin/bash

# List of packages to install
packages=(
  # Terminal
  lazygit
  lazydocker
  neovim
  fish
  zoxide

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
  ttf-firacode-nerd

  # Desktop Programs
  wezterm
  bitwarden
  btop
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

