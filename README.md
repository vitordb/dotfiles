
# My Dotfiles Repository

This repository contains my environment configurations, including Neovim, Tmux, Zsh, Git, and other essential tools. The following instructions explain how to clone this repository to a new machine and set up the required symlinks to make everything work correctly.

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

After cloning the repository, you need to create symlinks to apply the configurations to your system. Here are the commands to create the symlinks:

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

Depending on your environment, you may need to install a few dependencies. Below are common commands for Linux and WSL2:

#### Zsh and Oh-My-Zsh

Install Zsh and Oh-My-Zsh:

```bash
sudo apt update
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Git and GPG

If you're signing commits with GPG, install GPG and `pinentry`:

```bash
sudo apt install git gpg pinentry-curses
```

#### Neovim

Install Neovim:

```bash
sudo apt install neovim
```

#### Tmux

Install Tmux:

```bash
sudo apt install tmux
```

### 4. Configure GPG (if necessary)

If you're using GPG to sign commits, ensure that your `gpg-agent` configuration is correct. Add the following line to your `~/.gnupg/gpg-agent.conf` file (adjust the path if needed):

```bash
pinentry-program /usr/bin/pinentry-curses
```

Restart the GPG agent:

```bash
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

### 5. Install plugins and other tools (optional)

You may need to install some additional tools depending on your workflow. Here are some suggestions:

- **Lazygit**: If you use Lazygit, install it with:

  ```bash
  sudo add-apt-repository ppa:lazygit-team/release
  sudo apt update
  sudo apt install lazygit
  ```

- **Git LFS**: If you use Git LFS, install it with:

  ```bash
  sudo apt install git-lfs
  git lfs install
  ```

### 6. Update submodules (if necessary)

To ensure that submodules are always up to date, you can run:

```bash
git submodule update --remote --merge
```

---

By following these instructions, your environment should be correctly set up on a new machine. Remember to adjust the `.gitconfig.personal` file with sensitive information you don’t want to share publicly. Feel free to tweak this setup as needed.

---
