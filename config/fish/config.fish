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

# =============================================================================
# Environment Configuration
# =============================================================================

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

alias srv-prod-1="ssh sysadmin@192.168.100.4"
alias srv-prod-2="ssh sysadmin@192.168.100.6"

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
