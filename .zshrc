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

alias srv-dev="ssh sysadmin@192.168.100.14"
alias srv-prod-1="ssh sysadmin@192.168.100.4"
alias srv-prod-2="ssh sysadmin@192.168.100.6"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:$HOME/.mix/escripts

# Check if there is an active tmux session
if [ -z "$TMUX" ]; then
    if tmux has-session 2>/dev/null; then
        tmux attach
    else
        tmux new-session
    fi
fi

# Nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh
