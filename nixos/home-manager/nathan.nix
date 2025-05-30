{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nathan";
    homeDirectory = "/home/nathan";
    packages = with pkgs; [
      neofetch
      zsh
      oh-my-zsh
      oh-my-posh
      lazygit
      lazydocker
      tmux

      ripgrep
      fd
    ];

    file = {
      ".config/i3".source = ../../config/i3;
      ".config/tmux".source = ../../config/tmux;
      ".config/nvim".source = ../../config/nvim;
      ".config/lazydocker".source = ../../config/lazydocker;
      # ".config/lazygit".source = ../../config/lazygit;
      ".config/ohmyposh".source = ../../config/ohmyposh;
      ".config/rofi".source = ../../config/rofi;
      ".config/polybar".source = ../../config/polybar;
    };
  };

  programs = {
    home-manager.enable = true;
    neovim.enable = true;

    zsh = {
      enable = true;
      # ohMyZsh.enable = true;
    };

    git = {
      enable = true;
      userName = "Nathan Gomez";
      userEmail = "gomez.fede98@gmail.com";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
