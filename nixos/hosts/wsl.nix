{ config, lib, pkgs, ... }:

{
  # imports = [
  #   <nixos-wsl/modules>
  # ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.enable = true;
  wsl.defaultUser = "nathan";

  programs.nix-ld.enable = true;
  # Dynamic libraries for unpackaged programs
  programs.nix-ld.libraries = with pkgs; [
    libgcc
  ];

  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  # networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  system.stateVersion = "24.11";
}
