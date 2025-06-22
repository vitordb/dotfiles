# Meus Dotfiles

Este repositório contém minhas configurações pessoais de desenvolvimento, otimizadas para um fluxo de trabalho rápido e eficiente. A configuração principal é baseada no **NvChad**.

## Instalação Rápida

Para configurar um novo ambiente em qualquer máquina (Linux ou macOS), siga os passos abaixo.

### 1. Pré-requisitos

Certifique-se de que você tem os seguintes programas instalados:
- `git`
- `nvim` (Neovim 0.9.0 ou superior)
- `make` (para compilar alguns plugins)
- (Opcional) Uma [Nerd Font](https://www.nerdfonts.com/) para os ícones.

### 2. Clonar o Repositório

Clone este repositório para o local de sua preferência. A convenção é usar `~/.dotfiles`.

```bash
git clone https://github.com/vitordb/dotfiles.git ~/.dotfiles
```

### 3. Executar o Script de Instalação

O script `install.sh` criará todos os links simbólicos necessários.

```bash
cd ~/.dotfiles
./install.sh
```

O script irá:
- Remover qualquer configuração existente em `~/.config/nvim`.
- Criar um link simbólico de `~/.config/nvim` para este diretório.

### 4. Iniciar o Neovim

Abra o Neovim. O `lazy.nvim` irá automaticamente começar a instalar todos os plugins.

```bash
nvim
```

Aguarde a conclusão do processo. Pode ser necessário reiniciar o Neovim uma vez após a instalação.

---

E é isso! Seu ambiente está pronto para usar.

**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
