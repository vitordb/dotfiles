# Meus Dotfiles

Este repositório contém meus arquivos de configuração, como **Zsh**, **WezTerm**, **Neovim** e **Tmux**.

---

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

## Dependências

Para garantir o funcionamento correto das configurações, instale as seguintes ferramentas:

### Ferramentas Necessárias

1. **[Zsh](https://www.zsh.org/)**: Shell principal.
2. **[Oh My Zsh](https://ohmyz.sh/)**: Framework para gerenciar configurações do Zsh.
3. **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)**: Tema para o Zsh.
4. **[Neovim](https://neovim.io/)**: Editor de texto avançado.
5. **[WezTerm](https://wezfurlong.org/wezterm/)**: Terminal configurável.
6. **[Tmux](https://github.com/tmux/tmux)**: Multiplexador de terminais.
7. **[Node Version Manager (NVM)](https://github.com/nvm-sh/nvm)**: Gerenciador de versões do Node.js.
8. **[Eza](https://github.com/eza-community/eza)**: Substituto moderno para o comando `ls`.
9. **[Zoxide](https://github.com/ajeetdsouza/zoxide)**: Ferramenta para navegação inteligente entre diretórios.
10. **[Fzf](https://github.com/junegunn/fzf)**: Ferramenta para fuzzy finding.
11. **[SDKMAN](https://sdkman.io/)**: Gerenciador de versões para ferramentas como Java e Gradle.

### Instalação das Dependências

#### macOS

```bash
# Instalar Homebrew, caso ainda não tenha
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar dependências
brew install zsh neovim tmux node eza zoxide fzf
brew install --cask wezterm
brew install --cask font-meslo-lg-nerd-font
brew install --cask java
```

#### Linux (Ubuntu 22.04+)

```bash
# Atualizar repositórios
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install -y zsh neovim tmux nodejs unzip fzf fonts-powerline

# Instalar Eza
sudo apt install -y eza

# Instalar Zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Instalar WezTerm
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:wez/wezterm
sudo apt update
sudo apt install -y wezterm

# Instalar SDKMAN
curl -s "https://get.sdkman.io" | bash
```

#### Configuração do Powerlevel10k

```bash
# Instalar Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Configurar Powerlevel10k como tema no .zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"
```

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

Pronto! Agora seu `README.md` está completo e documentado com as dependências e instruções detalhadas. 🚀
