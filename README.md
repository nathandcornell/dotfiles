# Nate's dotfiles

## Quick Install (Recommended)

Run this on a fresh Mac - no prerequisites required:

```bash
curl -fsSL https://raw.githubusercontent.com/nathandcornell/dotfiles/master/bootstrap.sh | bash
```

This will:
1. Install Xcode Command Line Tools (if needed)
2. Install Homebrew (if needed)
3. Install Git (if needed)
4. Clone this repository to `~/dotfiles`
5. Initialize submodules
6. Run the full setup

### Custom Installation Directory

To install to a different location:

```bash
DOTFILES_DIR=~/my-dotfiles curl -fsSL https://raw.githubusercontent.com/nathandcornell/dotfiles/master/bootstrap.sh | bash
```

## Manual Installation

If you prefer to install manually or already have Git installed:

1. Clone this repo:
   ```bash
   git clone https://github.com/nathandcornell/dotfiles.git ~/dotfiles
   ```

2. Initialize submodules:
   ```bash
   cd ~/dotfiles
   git submodule update --init --recursive
   ```

3. Run dependencies script (installs Homebrew, Git, Node, Python, Bun, etc.):
   ```bash
   ./dependencies.sh
   ```

4. Run setup script (links configs, installs brew packages, sets up vim):
   ```bash
   ./setup.sh
   ```

5. Create your git user config:
   ```bash
   cp gitconfig-user.inc.example ~/.gitconfig-user.inc
   # Edit ~/.gitconfig-user.inc with your name and email
   ```

## What's Included

### Shell Configuration
- Zsh configuration with Oh My Zsh
- Powerlevel10k theme
- Extensive aliases for git, docker, and common tasks
- FZF integration with ripgrep

### Development Tools
- Vim/Neovim configuration with plugins (via vim submodule)
- Git configuration with useful aliases
- Homebrew packages (see `brew-packages`)

### Utility Scripts (~/bin)
- `cspr` - Create pull request
- `flush-dns` - Flush DNS cache
- `makeScratch` - Create scratch files
- And more...

## Optional: Extended Packages

For a more complete development environment, install additional packages:

```bash
xargs brew install < ~/dotfiles/brew-packages.local
```
