# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins - removidos plugins pesados que podem ser carregados sob demanda
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    web-search
    command-not-found
    extract
    history-substring-search
    sudo
)

source $ZSH/oh-my-zsh.sh

# System-specific settings
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS-specific configurations
  export PATH="/opt/homebrew/bin:$PATH"
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  alias ls="eza --icons=always"

  # Zoxide initialization
  if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
  fi
else
  # Linux-specific configurations
  if command -v exa &> /dev/null; then
    alias ls="exa --icons"
  else
    alias ls="ls --color=auto"
  fi
fi

# NVM - lazy loading para evitar lentidão no startup
export NVM_DIR="$HOME/.nvm"

# Flag para verificar se NVM já foi carregado
_nvm_loaded=false

# Função auxiliar para carregar NVM apenas quando necessário
_load_nvm() {
  # Se já foi carregado, não faz nada
  if [[ "$_nvm_loaded" == "true" ]]; then
    return 0
  fi
  
  # Carrega NVM se o diretório existir
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    _nvm_loaded=true
    return 0
  fi
  return 1
}

# NVM command - lazy loaded
# nvm.sh define nvm() como função de shell, então o wrapper precisa sair de cena
# antes da chamada real ("command" só enxerga binários externos).
nvm() {
  unfunction nvm
  if ! _load_nvm; then
    echo "nvm não encontrado em $NVM_DIR" >&2
    return 1
  fi
  nvm "$@"
}

# Node.js commands - carregam NVM automaticamente quando usados pela primeira vez
node() {
  _load_nvm 2>/dev/null
  command node "$@"
}

npm() {
  _load_nvm 2>/dev/null
  command npm "$@"
}

npx() {
  _load_nvm 2>/dev/null
  command npx "$@"
}

yarn() {
  _load_nvm 2>/dev/null
  command yarn "$@"
}

# Flutter configuration
export PATH="$PATH:$HOME/flutter/bin"

# Java & Android configuration - otimizado
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# JAVA_HOME - apenas se java estiver disponível
if command -v java &> /dev/null; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
  else
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java 2>/dev/null) 2>/dev/null)) 2>/dev/null)
  fi
fi

# Docker configuration - carrega init apenas se existir (geralmente é rápido)
# O comando docker funciona normalmente, isso apenas adiciona completions
[ -f "$HOME/.docker/init-zsh.sh" ] && source "$HOME/.docker/init-zsh.sh" 2>/dev/null

# Aliases
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always | delta" --pointer=" " | xargs git checkout'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias k='kubectl'
alias air='~/.air'

# SDKMAN - lazy loading
sdk() {
  unfunction sdk
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

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

# Completions - lazy loaded (carregadas na primeira vez que o comando é usado)
# Padrão: o wrapper se remove, carrega a completion e repassa a chamada.
# kubectl completion
if command -v kubectl &> /dev/null; then
  kubectl() {
    unfunction kubectl
    source <(command kubectl completion zsh 2>/dev/null)
    kubectl "$@"
  }
fi

# Angular CLI completion
# Sem guarda de "command -v": ng vem do node, que só entra no PATH sob demanda.
ng() {
  unfunction ng
  _load_nvm 2>/dev/null
  source <(command ng completion script 2>/dev/null)
  ng "$@"
}

# Go configuration - apenas se go estiver instalado
if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH 2>/dev/null)/bin
fi

export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"

# Plugins do Node.js - carregados sob demanda apenas se os comandos forem usados
# Os plugins do oh-my-zsh para node/npm/yarn/deno/volta adicionam principalmente aliases
# que podem ser carregados quando necessário, mas como são leves, podemos deixá-los
# comentados. Se precisar dos aliases, adicione os plugins de volta à lista acima.

# GitHub plugin (helpers empty_gh/new_gh/exist_gh) - lazy loaded
gh() {
  unfunction gh
  source "$ZSH/plugins/github/github.plugin.zsh" 2>/dev/null
  gh "$@"
}

# Gitignore plugin - lazy loaded
# gi é uma função do plugin, não um binário, então o wrapper cede o lugar pra ela.
gi() {
  unfunction gi
  source "$ZSH/plugins/gitignore/gitignore.plugin.zsh" 2>/dev/null || return 1
  gi "$@"
}

# VSCode plugin - lazy loaded
# O unfunction vem antes do source: o plugin faz "which code" pra decidir o binário.
code() {
  unfunction code
  source "$ZSH/plugins/vscode/vscode.plugin.zsh" 2>/dev/null
  code "$@"
}

# fubectl - fancy kubectl with fzf
[ -f ~/.local/bin/fubectl.source ] && source ~/.local/bin/fubectl.source
