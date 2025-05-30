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
      # ".config/tmux".source = ../../config/tmux;
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
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "dirhistory" "history" ];
        theme = "eastwood";
      };
    };

    git = {
      enable = true;
      userName = "Nathan Gomez";
      userEmail = "gomez.fede98@gmail.com";
    };

    tmux = {
      enable = true;
      prefix = "C-a";
      baseIndex = 1;
      newSession = true;
      # Stop tmux+escape craziness.
      escapeTime = 0;
      # Force tmux to use /tmp for sockets (WSL2 compat)
      secureSocket = false;

      plugins = with pkgs; [
        tmuxPlugins.catppuccin
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.tmux-fzf
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
      ];

      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        set-option -sa terminal-overrides ",xterm*:Tc"

        set -s escape-time 0
        set -g mouse on

        # Start windows and panes at 1, not 0
        # set -g base-index 1
        # set -g pane-base-index 1
        # set-window-option -g pane-base-index 1
        # set-option -g renumber-windows on

        # Vi copy mode
        setw -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

        # rename window to reflect current program
        setw -g automatic-rename on

        # Set new panes to open in current directory
        bind c new-window -c "#{pane_current_path}"
        bind-key h split-window -c "#{pane_current_path}"
        bind-key v split-window -h -c "#{pane_current_path}"

        # Use Alt + vim keys without prefix key to switch panes
        bind -n M-h select-pane -L
        bind -n M-l select-pane -R
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window
      '';
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
