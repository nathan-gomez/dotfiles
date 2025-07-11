# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ENABLE_CORRECTION="true"
plugins=(git docker docker-compose zsh-autosuggestions)

### Fix for making Docker plugin work
autoload -U compinit && compinit
###

# Alias
alias zshconfig="source ~/.zshrc"

alias nvimconfig="cd ~/.config/nvim"
alias lzg="lazygit"
alias lzd="lazydocker"
alias docker-prune="docker image prune -a && docker volume prune && docker volume prune -a && docker network prune"

# Uses fzf to open a file in nvim
alias nvimf='f=$(fzf-tmux -p) && [ -n "$f" ] && nvim "$f"'

alias srv-dev="ssh sysadmin@192.168.100.14"
alias srv-prod-1="ssh sysadmin@192.168.100.4"
alias srv-prod-2="ssh sysadmin@192.168.100.6"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:$HOME/.mix/escripts

export FZF_DEFAULT_OPTS="
    --border sharp
    --reverse
    --prompt '∷ '
    --pointer '▶ '
    --marker ⇒
    --scrollbar='▌'
    --highlight-line
    --color=hl:#f3be7c
    --color=bg:-1
    --color=gutter:-1
    --color=bg+:#252530
    --color=fg+:#aeaed1
    --color=hl+:#f3be7c
    --color=border:#606079
    --color=prompt:#bb9dbd
    --color=query:#aeaed1:bold
    --color=pointer:#aeaed1
    --color=scrollbar:#aeaed1
    --color=info:#f3be7c
    --color=spinner:#7fa563
    "

# Check if there is an active tmux session
if [ -z "$TMUX" ]; then
    if tmux has-session 2>/dev/null; then
        tmux attach
    else
        tmux new-session
    fi
fi

# Nvm setup
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export EDITOR="nvim"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source $ZSH/oh-my-zsh.sh
