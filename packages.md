## Install needed packages
```bash
# Development packages
yay -S neovim tmux alacritty lazygit lazydocker unzip flatpak fd ripgrep zsh

yay -S ttf-jetbrains-mono-nerd bitwarden btop ktorrent syncthing zerotier-one obsidian dotnet-host dotnet-runtime dotnet-sdk

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set zsh as default shell
chsh -s $(which zsh)
```

## Fix PipeWire crackling on VMs
```bash
# Install pipewire
sudo pacman -S pipewire pipewire-audio pipewire-pulse pipewire-alsa pipewire-jack wireplumber rtkit

sudo cp /usr/share/pipewire/pipewire.conf /etc/pipewire/

mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
nvim ~/.config/wireplumber/wireplumber.conf.d/50-alsa-config.conf

```

### Paste the contents inside the new file
```conf
monitor.alsa.rules = [
  {
    matches = [
      # This matches the value of the 'node.name' property of the node.
      {
        node.name = "~alsa_output.*"
      }
    ]
    actions = {
      # Apply all the desired node specific settings here.
      update-props = {
        api.alsa.period-size   = 1024
        api.alsa.headroom      = 8192
      }
    }
  }
]

```

```bash
# Restart audio driver
systemctl --user restart wireplumber pipewire pipewire-pulse
```
