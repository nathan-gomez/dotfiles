# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ENABLE_CORRECTION="true"
plugins=(git docker docker-compose)
plugins=(git docker docker-compose zsh-autosuggestions)

### Fix for making Docker plugin work
autoload -U compinit && compinit
###

# Alias
alias zshconfig="source ~/.zshrc"

alias lzg="lazygit"
alias lzd="lazydocker"
alias docker-prune="docker image prune -a && docker volume prune && docker volume prune -a && docker network prune"

alias srv-dev="ssh sysadmin@10.241.202.69"
alias srv-prod-1="ssh sysadmin@10.241.10.180"
alias srv-prod-2="ssh sysadmin@10.241.10.182"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/Applications/JetBrains_Rider/bin/
export PATH=$PATH:$HOME/.dotnet/tools

# Check if there is an active tmux session
# if [ -z "$TMUX" ]; then
#     if tmux has-session 2>/dev/null; then
#         tmux attach
#     else
#         tmux new-session
#     fi
# fi

# Homebrew setup
# test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

# Nvm setup
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec


eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.json)"

source $ZSH/oh-my-zsh.sh
