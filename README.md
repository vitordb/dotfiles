
# My Dotfiles Repository

This repository contains my environment configurations, including Neovim, Tmux, Zsh, Git, and other essential tools. Follow the steps below to clone this repository onto a new machine and set up the required symlinks to make everything work correctly.

## Installation Steps

### 1. Clone the repository with submodules

First, clone the `.dotfiles` repository and initialize the submodules to ensure all plugins (Tmux, Neovim) are cloned correctly:

```bash
git clone --recurse-submodules https://github.com/your-username/.dotfiles.git ~/.dotfiles
```

If you have already cloned the repository without submodules, manually initialize the submodules:

```bash
cd ~/.dotfiles
git submodule update --init --recursive
```

### 2. Create the necessary symlinks

After cloning the repository, you need to create symlinks to apply the configurations to your system. Run the following commands:

#### Zsh

```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```

#### Git

```bash
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.gitconfig.personal ~/.gitconfig.personal  # Only if the `.gitconfig.personal` file is needed
```

#### Neovim

```bash
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

#### Tmux

```bash
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
```

### 3. Install dependencies

Depending on your environment (Linux, macOS, or WSL2), you may need to install some dependencies. Here are the common commands for installation:

#### Homebrew (for macOS or Linux)

Install Homebrew if you don't have it yet:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install dependencies with Homebrew

```bash
brew install \
  git \
  tmux \
  neovim \
  fzf \
  ripgrep \
  fd \
  zsh \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  starship \
  markdownlint-cli \
  gpg
```

#### Install Nerd Fonts (optional)

To have better terminal icons, install a Nerd Font:

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

#### Node.js (needed for some Neovim features)

If you use Neovim with support for JavaScript/TypeScript, install Node.js:

```bash
brew install node
```

#### Oh-My-Zsh

Install Oh-My-Zsh:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### GPG and Git LFS

Install GPG and Git LFS if necessary:

```bash
brew install gpg git-lfs
git lfs install
```

### 4. Configure GPG (if necessary)

If you sign commits with GPG, ensure your `gpg-agent` configuration is correct. Add the following line to your `~/.gnupg/gpg-agent.conf` file (adjust the path if necessary):

```bash
pinentry-program /usr/bin/pinentry-curses
```

Restart the GPG agent:

```bash
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

### 5. Install plugins and other tools (optional)

You may need to install additional tools depending on your workflow. Here are some suggestions:

- **Lazygit**: If you use Lazygit, install it with:

  ```bash
  brew install lazygit
  ```

### 6. Update submodules (if necessary)

To ensure submodules are always up to date, you can run:

```bash
git submodule update --remote --merge
```

---

By following these instructions, your environment should be correctly set up on a new machine. Remember to adjust the `.gitconfig.personal` file with sensitive information you don’t want to share publicly. Feel free to tweak this setup as needed.


