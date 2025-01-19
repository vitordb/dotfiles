# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    web-search
    command-not-found
    extract
    deno
    docker
    github
    gitignore
    history-substring-search
    node
    npm
    nvm
    yarn
    volta
    vscode
    sudo
)

source $ZSH/oh-my-zsh.sh

# System-specific settings
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS-specific configurations
  export PATH="/opt/homebrew/bin:$PATH"
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  alias ls="eza --icons=always"

  # Zoxide initialization for macOS
  if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
  else
    echo "Zoxide not found. Please install it to enable 'z' functionality."
  fi
else
  # Linux-specific configurations
  if command -v exa &> /dev/null; then
    alias ls="exa --icons"
  else
    alias ls="ls --color=auto"
  fi
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Flutter configuration
export PATH="$PATH:$HOME/flutter/bin"

# Java & Android configuration
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

# Docker configuration (if installed)
[ -f "$HOME/.docker/init-zsh.sh" ] && source "$HOME/.docker/init-zsh.sh"

# Aliases
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always | delta" --pointer="" | xargs git checkout'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

# SDKMAN initialization
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Suppress output that could break instant prompt
[ -f ~/.gitlab_env ] && source ~/.gitlab_env

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source <(kubectl completion zsh)
