# Meus Dotfiles

Este repositório contém minhas configurações pessoais de desenvolvimento, otimizadas para um fluxo de trabalho rápido e eficiente. A base principal é o **Neovim** com a distribuição **NvChad**, mas também inclui configurações para **Zsh**, **Tmux**, **WezTerm** e outras ferramentas.

---

## Estrutura do Repositório

```plaintext
~/.dotfiles/
├── .config/
│   └── my-nvchad-config/  # Configuração principal do Neovim (NvChad)
│       ├── init.lua
│       └── lua/
│           ├── plugins.lua
│           └── ...
├── .zshrc             # Configuração do Zsh
├── .tmux.conf         # Configuração do Tmux
├── .wezterm.lua       # Configuração do WezTerm
├── install.sh         # Script para criar todos os symlinks
└── ...
```

---

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
git clone https://github.com/seu-usuario/dotfiles.git ~/.dotfiles
```

### 3. Executar o Script de Instalação

O script `install.sh` criará todos os links simbólicos necessários para as suas configurações, incluindo o Neovim.

```bash
cd ~/.dotfiles
./install.sh
```

O script irá:
- Remover qualquer configuração existente em `~/.config/nvim`.
- Criar um link simbólico de `~/.config/nvim` para o diretório `my-nvchad-config` deste repositório:

```bash
ln -sf ~/.dotfiles/.config/my-nvchad-config ~/.config/nvim
```

### 4. Iniciar o Neovim

Abra o Neovim. O `lazy.nvim` irá automaticamente começar a instalar todos os plugins definidos.

```bash
nvim
```

Aguarde a conclusão do processo. Pode ser necessário reiniciar o Neovim uma vez após a instalação.

---

E é isso! Seu ambiente está pronto para usar.

---

## Dependências

Para garantir o funcionamento correto das configurações, instale as seguintes ferramentas:

1. **[Zsh](https://www.zsh.org/)**: Shell principal.
2. **[Oh My Zsh](https://ohmyz.sh/)**: Framework para gerenciar configurações do Zsh.
3. **[Powerlevel10k](https://github.com/romkatv/powerlevel10k)**: Tema para o Zsh.
4. **[Neovim](https://neovim.io/)**: Editor de texto avançado.
5. **[WezTerm](https://wezfurlong.org/wezterm/)**: Terminal configurável.
6. **[Tmux](https://github.com/tmux/tmux)**: Multiplexador de terminais.
7. **[TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)**: Gerenciador de plugins para Tmux.
8. **[Node Version Manager (NVM)](https://github.com/nvm-sh/nvm)**: Gerenciador de versões do Node.js.
9. **[Eza](https://github.com/eza-community/eza)**: Substituto moderno para o comando `ls`.
10. **[Zoxide](https://github.com/ajeetdsouza/zoxide)**: Ferramenta para navegação inteligente entre diretórios.
11. **[Fzf](https://github.com/junegunn/fzf)**: Ferramenta para fuzzy finding.
12. **[SDKMAN](https://sdkman.io/)**: Gerenciador de versões para ferramentas como Java e Gradle.
13. **[Lazygit](https://github.com/jesseduffield/lazygit)**: Interface para Git.

---

## Sincronização em Novos Dispositivos

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/dotfiles.git ~/.dotfiles
   ```

2. Execute o script `install.sh` para criar os symlinks:

   ```bash
   cd ~/.dotfiles
   ./install.sh
   ```

3. Configure o **TPM** e instale os plugins como mostrado acima.

---

## Configurações Atuais

- **Zsh**: `.zshrc` com alias e configurações personalizadas.
- **WezTerm**: `.wezterm.lua` para terminal customizado.
- **Tmux**: `.tmux.conf` com atalhos, temas e plugins configurados.
- **Neovim**: Configurações organizadas em `.config/nvim` (linkadas para `my-nvchad-config`).

---

**This repo is supposed to be used as config by NvChad users!**

- O repositório principal do NvChad (NvChad/NvChad) é usado como plugin por este repo.
- Você importa os módulos normalmente, como `require "nvchad.options"`, `require "nvchad.mappings"`.
- Você pode deletar o `.git` deste repo (ao clonar localmente) ou fazer um fork :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter como inspiração para o starter do NvChad.
