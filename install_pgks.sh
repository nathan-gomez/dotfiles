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
  jq

  # Desktop pkgs #

  # Fonts
  ttf-jetbrains-mono-nerd
  ttf-firacode-nerd
  ttf-nerd-fonts-symbols

  # Desktop Programs
  wezterm
  btop
  syncthing
  zerotier-one
  obsidian
  eog
  qalculate-gtk

  # wayland apps
  azote
  cliphist
  grim
  slurp
  autotiling
  rofi
  mako
  foot
  polkit-gnome
  gnome-keyring
  seahorse
  network-manager-applet
  firewall-applet
  swappy
  swaylock-effects
  swaybg
  nwg-look # control gtk settings
  pamixer # sound control

  #timeshift
  #xhost # timeshift dependency

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

