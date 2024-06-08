# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ENABLE_CORRECTION="true"
plugins=(git docker docker-compose)

### Fix for making Docker plugin work
autoload -U compinit && compinit
###

# Alias
alias zshconfig="source ~/.zshrc"

alias projects="cd /mnt/e/Fede/Projects/"
alias obsidian="cd /mnt/e/Fede/Google\ Drive/Obsidian/Notebook"
alias vms="cd /mnt/d"

alias lzg="lazygit"
alias lzd="lazydocker"
alias vim="nvim"
alias rider="rider64.exe"
alias k="kubectl"
alias docker-prune="docker image prune -a && docker volume prune && docker volume prune -a && docker network prune"

alias srv-desa="ssh sysadmin@192.168.100.53"
alias srv-prod="ssh sysadmin@192.168.100.27"
alias desa-kmaster="ssh sysadmin@192.168.100.60"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/mnt/c/Program\ Files/JetBrains/JetBrains\ Rider\ 2023.3/bin

# Check if there is an active tmux session
if [ -z "$TMUX" ]; then
    if tmux has-session 2>/dev/null; then
        tmux attach
    else
        tmux new-session
    fi
fi

# Homebrew setup
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

# Nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.json)"

source $ZSH/oh-my-zsh.sh
