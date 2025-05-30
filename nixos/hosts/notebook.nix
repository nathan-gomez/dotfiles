{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "nixos-vm"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Localization
  time.timeZone = "America/Asuncion";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PY.UTF-8";
    LC_IDENTIFICATION = "es_PY.UTF-8";
    LC_MEASUREMENT = "es_PY.UTF-8";
    LC_MONETARY = "es_PY.UTF-8";
    LC_NAME = "es_PY.UTF-8";
    LC_NUMERIC = "es_PY.UTF-8";
    LC_PAPER = "es_PY.UTF-8";
    LC_TELEPHONE = "es_PY.UTF-8";
    LC_TIME = "es_PY.UTF-8";
  };

  # Users
  users.users.nathan = {
    isNormalUser = true;
    description = "nathan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
   git
   neovim
   firefox
   curl
   wget
   btop
   alacritty

   gnumake
   unzip
   zip
   jq
   fd
   ripgrep

   # WM
   # i3
   # polybar
   # rofi
   # haskellPackages.greenclip
   # nitrogen
   # nerd-fonts.jetbrains-mono

   home-manager
  ];

  # services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  # };

  programs.zsh = {
   enable = true;
   ohMyZsh = { enable = true; };
  };

  programs.nix-ld.enable = true;
  # Dynamic libraries for unpackaged programs
  programs.nix-ld.libraries = with pkgs; [];

  # Services
  services.openssh.enable = true;
  
  # Configure keymap in X11
  # services.xserver = {
  #  enable = true;
  #  desktopManager = {
  #   xterm.enable = false;
  #  };
  #
  #  windowManager.i3 = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #    dmenu
  #   ];
  #  };
  #
  #  xkb = {
  #   layout = "us";
  #   variant = "";
  #  };
  # };
  #
  # services.displayManager = {
  #  defaultSession = "none+i3";
  # };

  # programs.dconf.enable = true;

  system.stateVersion = "25.05";
}
