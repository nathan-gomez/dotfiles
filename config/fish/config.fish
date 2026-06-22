# =============================================================================
# Path Configuration
# =============================================================================

fish_add_path --prepend $HOME/.local/bin
fish_add_path --prepend $HOME/go/bin
fish_add_path --prepend $HOME/.dotnet/tools
fish_add_path --prepend $HOME/.local/share/zvm/bin
fish_add_path --prepend /opt/bin

# =============================================================================
# Environment Configuration
# =============================================================================

set fish_greeting

# Environment variables
set -gx EDITOR nvim

# Git Prompt Configuration
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showstashstate yes
set -g __fish_git_prompt_showuntrackedfiles yes
set -g __fish_git_prompt_showupstream yes
set -g __fish_git_prompt_color_branch fabd2f
set -g __fish_git_prompt_color_upstream_ahead d3869b
set -g __fish_git_prompt_color_upstream_behind fb4934
set -g __fish_git_prompt_color_dirtystate fe8019
set -g __fish_git_prompt_char_dirtystate "●"
set -g __fish_git_prompt_char_stagedstate "→"
set -g __fish_git_prompt_char_untrackedfiles "☡"
set -g __fish_git_prompt_char_stashstate "↩"
set -g __fish_git_prompt_char_upstream_ahead "+"
set -g __fish_git_prompt_char_upstream_behind "-"
set -g __fish_git_prompt_char_upstream_equal ""

# Prompt Function Theme
function fish_prompt
    set -l last_status $status
    set_color d3869b
    echo -n "Δ "
    set_color 83a598
    printf "%s" (string replace $HOME "~" (pwd))
    set_color normal
    printf "%s" (__fish_git_prompt)
    if test $last_status -ne 0
        set_color fb4934
        printf " [%d]" $last_status
        set_color normal
    end
    set_color 83a598
    printf " ➤ "
    set_color normal
end

# Right-hand Prompt Function
function fish_right_prompt
    set_color d3869b
    printf "("
    set_color 83a598
    printf "%s" (hostname)
    set_color d3869b
    printf ") "
    set_color normal
    printf "%s" (date "+%H:%M:%S")
end

# =============================================================================
# Aliases & Functions
# =============================================================================

alias reload='source ~/.config/fish/config.fish'

# Vim/Vi aliases to nvim
alias vim='nvim'
alias vi='nvim'

# Directory listing with lsd
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'

alias lzg='lazygit'
alias lzd='lazydocker'

alias gamma="ssh -i ~/.ssh/personal sysadmin@192.168.100.15"

# Places
alias notes="cd ~/windows/Fede/gdrive/notes"
alias fede="cd ~/windows/Fede"
alias dev="cd ~/windows/Fede/dev"

# TODO: add tray notification
# alias vpnup="sudo ipsec up abstra"
# alias vpndown="sudo ipsec down abstra"
# alias vpnstatus="sudo ipsec status"

zoxide init fish | source

# =============================================================================
# Sway Auto-start
# =============================================================================

# Auto-start Sway on TTY1
if test (tty) = /dev/tty1
    # Make Qt/KDE apps follow the GTK dark theme instead of defaulting to light
    set -gx QT_QPA_PLATFORMTHEME gtk3
    exec sway
end

# =============================================================================
# Theme Colors
# =============================================================================

# Gorgoroth theme
# Syntax Highlighting Colors
set -g fish_color_normal c1c1c1
set -g fish_color_command 888888
set -g fish_color_keyword 999999
set -g fish_color_quote ddeecc
set -g fish_color_redirection aaaaaa
set -g fish_color_end 9b99a3
set -g fish_color_error 5f8787
set -g fish_color_param c1c1c1
set -g fish_color_valid_path 9b8d7f
set -g fish_color_option 5f8787
set -g fish_color_comment 505050
set -g fish_color_selection --background=000000
set -g fish_color_operator 9b99a3
set -g fish_color_escape 999999
set -g fish_color_autosuggestion 505050
set -g fish_color_cwd ddeecc
set -g fish_color_hostname aaaaaa
set -g fish_color_status 5f8787
set -g fish_color_cancel aaaaaa
set -g fish_color_search_match --background=000000

# Completion Pager Colors
set -g fish_pager_color_progress 5f8787
set -g fish_pager_color_prefix 9b8d7f
set -g fish_pager_color_completion c1c1c1
set -g fish_pager_color_description 505050
set -g fish_pager_color_selected_prefix 5f8787
set -g fish_pager_color_selected_completion 5f8787
set -g fish_pager_color_selected_background --background=000000

# Gruvbox Dark Theme
# set --global fish_color_autosuggestion 928374
# set --global fish_color_cancel --reverse
# set --global fish_color_command b8bb26
# set --global fish_color_comment 928374 --italics
# set --global fish_color_cwd fabd2f
# set --global fish_color_cwd_root fb4934
# set --global fish_color_end 8ec07c
# set --global fish_color_error fb4934
# set --global fish_color_escape d3869b
# set --global fish_color_history_current ebdbb2 --bold
# set --global fish_color_host b8bb26
# set --global fish_color_host_remote fabd2f
# set --global fish_color_keyword fb4934
# set --global fish_color_normal normal
# set --global fish_color_operator 8ec07c
# set --global fish_color_option 83a598
# set --global fish_color_param ebdbb2
# set --global fish_color_quote b8bb26
# set --global fish_color_redirection d3869b --bold
# set --global fish_color_search_match --bold --background=504945
# set --global fish_color_selection ebdbb2 --bold --background=504945
# set --global fish_color_status fb4934
# set --global fish_color_user b8bb26
# set --global fish_color_valid_path --underline=single
# set --global fish_pager_color_background
# set --global fish_pager_color_completion ebdbb2
# set --global fish_pager_color_description fabd2f --italics
# set --global fish_pager_color_prefix normal --bold --underline=single
# set --global fish_pager_color_progress 1d2021 --bold --background=fe8019
# set --global fish_pager_color_secondary_background
# set --global fish_pager_color_secondary_completion
# set --global fish_pager_color_secondary_description
# set --global fish_pager_color_secondary_prefix
# set --global fish_pager_color_selected_background --background=504945
# set --global fish_pager_color_selected_completion
# set --global fish_pager_color_selected_description
# set --global fish_pager_color_selected_prefix
