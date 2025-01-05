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

### 3. Configurar o Tmux Plugin Manager (TPM)

O **TPM** é necessário para gerenciar os plugins do Tmux configurados no arquivo `.tmux.conf`.

#### Instalar o TPM:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### Instalar os plugins configurados:

1. Abra o Tmux:
   ```bash
   tmux
   ```
2. Dentro de uma sessão do Tmux, pressione:
   ```text
   Prefixo (Ctrl-a) + I
   ```
   Isso instalará todos os plugins listados no arquivo `.tmux.conf`.

---

### 4. Aproveite as Configurações

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

2. Execute o script `setup.sh` para criar os symlinks:

   ```bash
   cd ~/.dotfiles
   ./setup.sh
   ```

3. Configure o **TPM** e instale os plugins como mostrado acima.

---

## Configurações Atuais

- **Zsh**: `.zshrc` com alias e configurações personalizadas.
- **WezTerm**: `.wezterm.lua` para terminal customizado.
- **Tmux**: `.tmux.conf` com atalhos, temas e plugins configurados.
- **Neovim**: Configurações organizadas em `.config/nvim`.

---
