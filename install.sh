#!/bin/bash
# Script para criar links simbólicos das configurações de dotfiles

# Diretório raiz do repositório .dotfiles
DOTFILES_DIR="$HOME/.dotfiles"

# Symlink do Neovim (remove se já existir)
NVIM_DEST="$HOME/.config/nvim"
NVIM_SRC="$DOTFILES_DIR/.config/my-nvchad-config"

echo "⚙️  Configurando symlinks do Neovim e dotfiles..."

if [ -L "$NVIM_DEST" ] || [ -d "$NVIM_DEST" ]; then
    echo "⚠️  Configuração existente encontrada em $NVIM_DEST. Removendo para criar novo link."
    rm -rf "$NVIM_DEST"
fi
ln -s "$NVIM_SRC" "$NVIM_DEST"
echo "✅ Link simbólico do Neovim criado: $NVIM_DEST -> $NVIM_SRC"

# Symlinks para arquivos na raiz do diretório home
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "✅ Symlinks de dotfiles criados com sucesso!" 