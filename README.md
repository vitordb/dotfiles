
# Meus Dotfiles

Este repositório contém meus arquivos de configuração, como **Zsh**, **WezTerm**, **Neovim** e **Tmux**.

## Estrutura do Repositório

```plaintext
~/.dotfiles/
├── .config/
│   └── nvim/        # Apenas configurações específicas do Neovim
├── .wezterm.lua     # Configuração do WezTerm
├── .zshrc           # Configuração do Zsh
├── .tmux.conf       # Configuração do Tmux
├── setup.sh         # Script para recriar os symlinks
└── README.md        # Instruções de uso
```

---

## Como Usar

### 1. Clonar o Repositório

Clone o repositório para o diretório `~/.dotfiles`:

```bash
git clone https://github.com/seu-usuario/dotfiles.git ~/.dotfiles
```

---

### 2. Criar os Symlinks

Execute o script `setup.sh` para criar os symlinks automaticamente:

```bash
cd ~/.dotfiles
./setup.sh
```

Se preferir criar os symlinks manualmente, use os comandos abaixo:

```bash
# Symlink para o Zsh
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

# Symlink para o WezTerm
ln -sf ~/.dotfiles/.wezterm.lua ~/.wezterm.lua

# Symlink para o Tmux
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Symlink para a configuração do Neovim
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
```

---

### 3. Aproveite as Configurações

Após rodar o script ou criar os symlinks manualmente, as configurações do **Zsh**, **WezTerm**, **Neovim** e **Tmux** estarão prontas para uso!

---

## Adicionando ou Alterando Arquivos

1. Faça as alterações diretamente nos arquivos no diretório `~/.dotfiles` ou nos symlinks.
2. Adicione e faça commit das alterações:
   ```bash
   git add .
   git commit -m "Atualizando configurações do dotfiles"
   git push
   ```

---

## Sincronização em Novos Dispositivos

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/dotfiles.git ~/.dotfiles
   ```

2. Execute o script `setup.sh` para criar os symlinks:
   ```bash
   cd ~/.dotfiles
   ./setup.sh
   ```

---

## Configurações Atuais

- **Zsh**: `.zshrc` com alias e configurações personalizadas.
- **WezTerm**: `.wezterm.lua` para terminal customizado.
- **Tmux**: `.tmux.conf` com atalhos e configurações específicas.
- **Neovim**: Configurações organizadas em `.config/nvim`.

---

Pronto! Com esse `README.md`, qualquer pessoa (incluindo você em outro dispositivo) pode usar o repositório de maneira fácil e prática. 🚀
