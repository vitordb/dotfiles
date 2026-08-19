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
├── .gitconfig         # Configuração do Git
├── tmux.conf          # Configuração do Tmux
├── .wezterm.lua       # Configuração do WezTerm
├── Brewfile           # Dependências instaladas no macOS
├── install.sh         # Bootstrap completo: pacotes, plugins e symlinks
└── ...
```

---

## Instalação Rápida

Em uma máquina nova, do zero:

```bash
git clone https://github.com/vitordb/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

O repositório não precisa ficar em `~/.dotfiles`. O script descobre o próprio
caminho, então funciona de onde você clonar.

### O que o script faz

1. **Instala as dependências.** No macOS, via Homebrew e o `Brewfile` (instala o
   próprio Homebrew se não houver). No Linux, via `apt-get` ou `dnf`.
2. **Faz o bootstrap dos gerenciadores de plugin:** oh-my-zsh e seus plugins,
   powerlevel10k, nvm e o tpm do tmux.
3. **Cria os symlinks** de zsh, git, tmux, WezTerm e Neovim.

É idempotente: rodar de novo não duplica nada. Se já existir um arquivo de
verdade no lugar de um symlink, ele é movido para `.bak-<timestamp>` em vez de
apagado.

No Linux o script instala o Neovim a partir do release oficial quando o pacote
da distro é anterior ao 0.11. O Ubuntu 24.04, por exemplo, entrega o 0.9.5, no
qual esta config nem carrega (usa `vim.uv` e `vim.lsp.config`).

> Testado ponta a ponta em container limpo de **Ubuntu 24.04** e no **macOS**.
> O ramo `dnf` (Fedora e derivados) foi escrito mas não foi exercitado.
> `eza`, `git-delta`, `lazygit`, `tealdeer` e `kubectl` não estão nos repos
> padrão de toda distro; instale à parte se algum alias reclamar.

### Passos que sobram

Dois passos precisam de sessão interativa e o script não faz por você:

- No tmux, `prefix + I` (prefix é `Ctrl-a`) para o tpm baixar os plugins.
- Abrir o `nvim` uma vez, para o lazy.nvim se instalar e baixar os plugins.

### Configuração local, fora do repo

O `.gitconfig` inclui `~/.gitconfig-local`, que **não** é versionado. É onde
ficam identidades de trabalho e qualquer coisa específica da máquina. O git
ignora silenciosamente se o arquivo não existir.

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
- **Tmux**: `tmux.conf` com atalhos, temas e plugins configurados.
- **Neovim**: Configurações organizadas em `.config/nvim` (linkadas para `my-nvchad-config`).

---

**This repo is supposed to be used as config by NvChad users!**

- O repositório principal do NvChad (NvChad/NvChad) é usado como plugin por este repo.
- Você importa os módulos normalmente, como `require "nvchad.options"`, `require "nvchad.mappings"`.
- Você pode deletar o `.git` deste repo (ao clonar localmente) ou fazer um fork :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter como inspiração para o starter do NvChad.
