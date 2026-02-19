# Greeting with fastfetch if available - with delay for terminal sizing
function fish_greeting
    if command -v fastfetch >/dev/null 2>&1
        # Small delay to ensure terminal is fully sized
        sleep 0.1
        command fastfetch --logo-width 20 --logo arch
    end
end

# =============================================================================
# Path Configuration
# =============================================================================

fish_add_path --prepend $HOME/.local/bin
fish_add_path --prepend $HOME/go/bin
fish_add_path --prepend $HOME/.dotnet/tools
fish_add_path --prepend $HOME/.zvm/bin
fish_add_path --prepend /opt/bin

# =============================================================================
# Environment Configuration
# =============================================================================

# Set Vi mode
set --global fish_key_bindings fish_vi_key_bindings

# Environment variables
set -gx EDITOR nvim

# Git Prompt Configuration
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showstashstate yes
set -g __fish_git_prompt_showuntrackedfiles yes
set -g __fish_git_prompt_showupstream yes
set -g __fish_git_prompt_color_branch yellow
set -g __fish_git_prompt_color_upstream_ahead purple
set -g __fish_git_prompt_color_upstream_behind red
set -g __fish_git_prompt_color_dirtystate 'ff8c00'
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
    set_color purple
    echo -n "λ "
    set_color normal
    set_color blue
    printf "%s" (string replace $HOME "~" (pwd))
    set_color normal
    printf "%s" (__fish_git_prompt)
    if test $last_status -ne 0
        set_color red
        printf " [%d]" $last_status
        set_color normal
    end
    set_color cyan
    printf " ➤ "
    set_color normal
end

# =============================================================================
# Aliases & Functions
# =============================================================================

alias reload='source ~/.config/fish/config.fish'
alias tm='tmux'

# Vim/Vi aliases to nvim
alias vim='nvim'
alias vi='nvim'

# Directory listing with lsd
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'

alias lzg='lazygit'
alias lzd='lazydocker'

alias grep='grep --color=auto'

alias clear_clip='cliphist wipe'

alias srv-prod-1="ssh sysadmin@192.168.100.4"
alias srv-prod-2="ssh sysadmin@192.168.100.6"

# Places
alias notes="cd /mnt/hdd/Fede/gdrive/notes"
alias fede="cd /mnt/hdd/Fede"

# Fastfetch with correct logo width
alias fastfetch='command fastfetch --logo-width 20'

# Disk usage - show top 10 largest items by size
function dum
    du -sm * | sort -nr | head -10
end

# =============================================================================
# Sway Auto-start
# =============================================================================

# Auto-start Sway on TTY1
if test (tty) = /dev/tty1
    exec sway
end

# Right-hand Prompt Function
function fish_right_prompt
    set_color purple
    printf "("
    set_color cyan
    printf "%s" (hostname)
    set_color purple
    printf ") "
    set_color blue
    printf "%s" (date "+%H:%M:%S")
    set_color normal
end

# =============================================================================
# Theme Colors
# =============================================================================

# Nord Theme
set --global fish_color_autosuggestion 4c566a
set --global fish_color_cancel --reverse
set --global fish_color_command 88c0d0
set --global fish_color_comment 4c566a --italics
set --global fish_color_cwd 5e81ac
set --global fish_color_cwd_root bf616a
set --global fish_color_end 81a1c1
set --global fish_color_error bf616a
set --global fish_color_escape ebcb8b
set --global fish_color_history_current e5e9f0 --bold
set --global fish_color_host a3be8c
set --global fish_color_host_remote ebcb8b
set --global fish_color_keyword 81a1c1
set --global fish_color_normal normal
set --global fish_color_operator 81a1c1
set --global fish_color_option 8fbcbb
set --global fish_color_param d8dee9
set --global fish_color_quote a3be8c
set --global fish_color_redirection b48ead --bold
set --global fish_color_search_match --bold --background=434c5e
set --global fish_color_selection d8dee9 --bold --background=434c5e
set --global fish_color_status bf616a
set --global fish_color_user a3be8c
set --global fish_color_valid_path --underline=single
set --global fish_pager_color_background
set --global fish_pager_color_completion e5e9f0
set --global fish_pager_color_description ebcb8b --italics
set --global fish_pager_color_prefix normal --bold --underline=single
set --global fish_pager_color_progress 3b4252 --bold --background=d08770
set --global fish_pager_color_secondary_background
set --global fish_pager_color_secondary_completion
set --global fish_pager_color_secondary_description
set --global fish_pager_color_secondary_prefix
set --global fish_pager_color_selected_background --background=434c5e
set --global fish_pager_color_selected_completion
set --global fish_pager_color_selected_description
set --global fish_pager_color_selected_prefix
