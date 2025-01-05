#!/bin/bash

# Caminho para o diretório .dotfiles
DOTFILES_DIR="$HOME/.dotfiles"

echo "Criando symlinks para os dotfiles..."

# Symlinks para arquivos na raiz do diretório home
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Symlinks específicos dentro do .config
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "Symlinks criados com sucesso!"
