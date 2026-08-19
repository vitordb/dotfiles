#!/usr/bin/env bash
#
# Bootstrap completo dos dotfiles.
#
#   git clone <repo> && cd <repo> && ./install.sh
#
# Instala as dependências, faz o bootstrap dos gerenciadores de plugin e cria
# os symlinks. É idempotente: rodar de novo não duplica nada e não gera backup
# de arquivo que o próprio script já linkou.
#
set -euo pipefail

# Deriva o diretório do próprio script, então o repo pode estar clonado em
# qualquer caminho, não só em ~/.dotfiles.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM_DIR="$HOME/.oh-my-zsh/custom"

bold="$(tput bold 2>/dev/null || true)"
reset="$(tput sgr0 2>/dev/null || true)"
step() { printf '\n%s==> %s%s\n' "$bold" "$1" "$reset"; }
ok()   { printf '  ✓ %s\n' "$1"; }
warn() { printf '  ! %s\n' "$1"; }
die()  { printf '\nErro: %s\n' "$1" >&2; exit 1; }

case "${OSTYPE:-}" in
  darwin*) OS=macos ;;
  linux*)  OS=linux ;;
  *)       die "sistema não suportado: ${OSTYPE:-desconhecido}" ;;
esac

# ---------------------------------------------------------------- utilitários

# Cria um symlink de forma idempotente.
#   - já aponta pro lugar certo -> não faz nada
#   - symlink apontando pra outro lugar -> substitui
#   - arquivo ou diretório de verdade -> move pra .bak-<timestamp> antes
link() {
  local src="$1" dest="$2"

  if [ ! -e "$src" ]; then
    warn "pulando $dest: $src não existe no repo"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    if [ "$(readlink "$dest")" = "$src" ]; then
      ok "$(basename "$dest") já aponta pro repo"
      return 0
    fi
    rm "$dest"
  elif [ -e "$dest" ]; then
    local bak="$dest.bak-$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$bak"
    warn "$dest existia de verdade, movido pra $(basename "$bak")"
  fi

  ln -s "$src" "$dest"
  ok "$(basename "$dest") -> $src"
}

# Clona um repo só se ainda não estiver lá.
clone_once() {
  local repo="$1" dest="$2" name="$3"

  if [ -d "$dest/.git" ]; then
    ok "$name já instalado"
    return 0
  fi
  if [ -e "$dest" ]; then
    warn "$name: $dest já existe e não é um clone git, deixando como está"
    return 0
  fi

  git clone --depth=1 "$repo" "$dest" >/dev/null 2>&1
  ok "$name instalado"
}

# ------------------------------------------------------------------- pacotes

install_packages_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    step "Instalando o Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi

  step "Instalando pacotes do Brewfile"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
}

install_packages_linux() {
  step "Instalando pacotes (Linux)"

  # Em container ou como root não existe (nem precisa de) sudo.
  local sudo=""
  if [ "$(id -u)" -ne 0 ]; then
    command -v sudo >/dev/null 2>&1 \
      || die "sem root e sem sudo: não dá pra instalar os pacotes"
    sudo="sudo"
  fi

  if command -v apt-get >/dev/null 2>&1; then
    $sudo apt-get update
    $sudo apt-get install -y \
      zsh git curl tmux neovim golang-go ripgrep fd-find fzf zoxide \
      eza git-delta tealdeer
  elif command -v dnf >/dev/null 2>&1; then
    $sudo dnf install -y \
      zsh git curl tmux neovim golang ripgrep fd-find fzf zoxide \
      eza git-delta tealdeer
  else
    die "nenhum gerenciador de pacotes conhecido (apt-get ou dnf)"
  fi

  # Debian e Ubuntu entregam o fd como "fdfind". O telescope procura por "fd".
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    $sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    ok "fd apontando pro fdfind"
  fi

  ensure_modern_neovim "$sudo"
}

# A config usa vim.uv (0.10+) e vim.lsp.config (0.11+). O neovim empacotado
# pelas distros costuma ser velho demais: o Ubuntu 24.04 entrega 0.9.5, onde a
# config nem carrega. Nesse caso, instala o binário oficial.
ensure_modern_neovim() {
  local sudo="${1:-}"

  if command -v nvim >/dev/null 2>&1 &&
     [ "$(nvim --headless -c 'lua io.write(vim.fn.has("nvim-0.11"))' \
          -c 'qa!' 2>/dev/null)" = "1" ]; then
    ok "neovim $(nvim --version | head -1 | awk '{print $2}') serve"
    return 0
  fi

  warn "neovim ausente ou anterior ao 0.11, instalando o release oficial"

  local arch tarball
  case "$(uname -m)" in
    x86_64)          arch=x86_64 ;;
    aarch64|arm64)   arch=arm64 ;;
    *) warn "arquitetura $(uname -m) sem release oficial, pulando"; return 0 ;;
  esac
  tarball="nvim-linux-${arch}.tar.gz"

  local tmp; tmp="$(mktemp -d)"
  if ! curl -fsSL -o "$tmp/$tarball" \
       "https://github.com/neovim/neovim/releases/latest/download/$tarball"; then
    warn "falhou baixar o $tarball, seguindo com o neovim que existir"
    rm -rf "$tmp"; return 0
  fi

  $sudo rm -rf /opt/nvim
  $sudo mkdir -p /opt/nvim
  $sudo tar -xzf "$tmp/$tarball" -C /opt/nvim --strip-components=1
  $sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp"
  ok "neovim $(/opt/nvim/bin/nvim --version | head -1 | awk '{print $2}') instalado em /opt/nvim"
}

# ----------------------------------------------------------------- bootstrap

bootstrap_shell() {
  step "Bootstrap do zsh"
  clone_once https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" "oh-my-zsh"
  clone_once https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" "zsh-autosuggestions"
  clone_once https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting"
  # O .zshrc usa ZSH_THEME="powerlevel10k/powerlevel10k", que o oh-my-zsh
  # resolve neste caminho. No macOS o brew também instala, mas o tema precisa
  # existir aqui de qualquer forma.
  clone_once https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM_DIR/themes/powerlevel10k" "powerlevel10k"
}

bootstrap_nvm() {
  step "Bootstrap do nvm"
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
    ok "nvm já instalado"
    return 0
  fi
  # Clone direto em vez do instalador oficial: o instalador acrescenta linhas
  # no ~/.zshrc, que aqui é um symlink pro repo.
  git clone https://github.com/nvm-sh/nvm.git "$HOME/.nvm" >/dev/null 2>&1
  git -C "$HOME/.nvm" checkout \
    "$(git -C "$HOME/.nvm" describe --abbrev=0 --tags)" >/dev/null 2>&1
  ok "nvm instalado"
}

bootstrap_tmux() {
  step "Bootstrap do tmux"
  clone_once https://github.com/tmux-plugins/tpm.git \
    "$HOME/.tmux/plugins/tpm" "tpm"
}

# Em vez de listar de cor o que falta em cada distro, olha o que de fato não
# ficou instalado. Nada aqui é essencial, mas cada um sustenta algum alias.
report_missing_optional() {
  local missing="" c
  for c in eza delta lazygit tldr kubectl; do
    command -v "$c" >/dev/null 2>&1 || missing="$missing $c"
  done
  [ -n "$missing" ] || return 0

  warn "não encontrados:$missing"
  case "$missing" in
    *eza*)     warn "  eza     -> o alias ls cai pro ls --color=auto" ;;
  esac
  case "$missing" in
    *delta*)   warn "  delta   -> o alias cbr perde o preview do diff" ;;
  esac
  case "$missing" in
    *lazygit*) warn "  lazygit -> o atalho <leader>lg do nvim não abre" ;;
  esac
  case "$missing" in
    *tldr*)    warn "  tldr    -> o alias tldrf não funciona" ;;
  esac
  case "$missing" in
    *kubectl*) warn "  kubectl -> o alias k não funciona" ;;
  esac
}

# ------------------------------------------------------------------ symlinks

create_symlinks() {
  step "Criando symlinks"
  link "$DOTFILES_DIR/.zshrc"       "$HOME/.zshrc"
  link "$DOTFILES_DIR/.gitconfig"   "$HOME/.gitconfig"
  link "$DOTFILES_DIR/.p10k.zsh"    "$HOME/.p10k.zsh"
  link "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
  link "$DOTFILES_DIR/tmux.conf"    "$HOME/.tmux.conf"
  link "$DOTFILES_DIR/.config/my-nvchad-config" "$HOME/.config/nvim"
}

# ----------------------------------------------------------------------- main

printf '%sDotfiles%s  origem: %s  sistema: %s\n' "$bold" "$reset" "$DOTFILES_DIR" "$OS"

command -v git >/dev/null 2>&1 || die "git é necessário e não foi encontrado"

case "$OS" in
  macos) install_packages_macos ;;
  linux) install_packages_linux ;;
esac

report_missing_optional

bootstrap_shell
bootstrap_nvm
bootstrap_tmux
create_symlinks

step "Pronto"
cat <<'EOF'
  Faltam dois passos que precisam de sessão interativa:

    1. Abra o tmux e aperte  prefix + I  (prefix = Ctrl-a) para o tpm
       baixar os plugins do tmux.
    2. Abra o nvim uma vez. O lazy.nvim se instala sozinho e baixa os
       plugins na primeira execução.

  Se o zsh ainda não for seu shell padrão:  chsh -s "$(which zsh)"
EOF
