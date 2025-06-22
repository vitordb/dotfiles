#!/bin/bash
# Script para criar links simbólicos das configurações de dotfiles

# Encontra o diretório onde o script está localizado (a raiz do repo .dotfiles)
# Isso torna o script portátil e executável de qualquer lugar.
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Onde o Neovim espera encontrar suas configurações
DEST_DIR="$HOME/.config/nvim"

echo "⚙️  Iniciando configuração do Neovim..."

# Verifica se um link ou diretório já existe no local de destino
if [ -L "$DEST_DIR" ] || [ -d "$DEST_DIR" ]; then
    echo "⚠️  Configuração existente encontrada em $DEST_DIR. Removendo para criar novo link."
    rm -rf "$DEST_DIR"
fi

# Cria o link simbólico
ln -s "$SOURCE_DIR" "$DEST_DIR"

echo "✅ Link simbólico criado com sucesso!"
echo "   $DEST_DIR -> $SOURCE_DIR"
echo "🚀 Agora você pode iniciar o Neovim!" 