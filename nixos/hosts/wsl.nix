{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.enable = true;
  wsl.defaultUser = "nathan";

  programs.nix-ld.enable = true;
  # Dynamic libraries for unpackaged programs
  programs.nix-ld.libraries = with pkgs; [ ];

  # Networking
  networking.hostName = "nixos";
  # networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  users.users.nathan = {
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl

    toybox
  ];

  system.stateVersion = "24.11";
}
