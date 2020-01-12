#!/bin/sh

SCRIPT_PATH=$( realpath "$0" )
SCRIPT_DIR=$( dirname "$SCRIPT_PATH" )

# Install Homebrew:
if ! command -v brew; then
  echo "Installing Homebrew\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! command -v git; then
  echo "Installing Git\n"
  brew install git
fi

if ! [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh\n"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
fi

if ! command -v npm; then
  echo "Installing Node\n"
  brew install nodejs
fi

if ! command -v pip3; then
  echo "Installing Python3\n"
  brew install python3
fi

if ! command -v pip2; then
  echo "Installing Python2\n"
  brew install python2
fi

if ! command -v pyenv; then
  echo "Installing PyEnv\n"
  brew install pyenv
fi

echo "Installing Homebrew packages\n"
xargs brew install < "$SCRIPT_DIR"/brew-packages

# TODO:
# echo "Installing Node packages\n"

