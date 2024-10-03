# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set TERM based on tmux presence or terminal type
if [ -n "$TMUX" ]; then
    export TERM="tmux-256color"
else
    case "$TERM" in
        xterm*|screen*)
            export TERM="xterm-256color"
            ;;
        *)
            export TERM="xterm-color"
            ;;
    esac
fi

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Configure auto-update behavior
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# Set the history timestamp format
HIST_STAMPS="mm/dd/yyyy"

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
    yarn
    volta
    vscode
    sudo
    z
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Lazy load NVM (Node Version Manager)
lazy_load_nvm() {
    unset -f node npm npx nvm
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        \. "$NVM_DIR/nvm.sh"
        nvm "$@"
    fi
}

for cmd in node npm npx nvm; do
    eval "$cmd() { lazy_load_nvm; $cmd \"\$@\"; }"
done

# Platform-specific configurations

# WSL-specific settings
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    export PATH="$PATH:$HOME/flutter/bin"
    export PYTHON="$HOME/.pyenv/versions/3.10.6/bin/python"

# macOS-specific settings
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -x "$(command -v brew)" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    export PATH="$PATH:$(pwd)/flutter/bin"
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
    [ -f "$HOME/.docker/init-zsh.sh" ] && source "$HOME/.docker/init-zsh.sh"

# Linux-specific settings
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -x "$(command -v brew)" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    export PATH="$PATH:$HOME/flutter/bin"
    export PYTHON="$HOME/.pyenv/versions/3.10.6/bin/python"
fi

# Aliases
alias lua='lua_cd'
alias lz='lazygit'
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always | delta" --pointer="" | xargs git checkout'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

# Functions
function lua_cd() {
    cd "$HOME/.config/nvim/lua"
}

# Set default user for prompt
DEFAULT_USER=$(whoami)

# SDKMAN initialization (only load if exists)
if [ -d "$HOME/.sdkman" ]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load GitLab environment settings if available
[ -f ~/.gitlab_env ] && source ~/.gitlab_env

# Google Cloud SDK (macOS specific)
if [[ "$OSTYPE" == "darwin"* && -f '/Users/dbvitor/Downloads/google-cloud-sdk/path.zsh.inc' ]]; then 
    . '/Users/dbvitor/Downloads/google-cloud-sdk/path.zsh.inc'
    . '/Users/dbvitor/Downloads/google-cloud-sdk/completion.zsh.inc'
fi
