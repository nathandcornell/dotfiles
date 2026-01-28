#!/bin/sh

SCRIPT_PATH=$( realpath "$0" )
SCRIPT_DIR=$( dirname "$SCRIPT_PATH" )

# Install Homebrew:
if ! command -v brew; then
  echo "Installing Homebrew\n"
  curl -fsSLo /tmp/hombrew-install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  chmod +x /tmp/hombrew-install.sh
  /tmp/hombrew-install.sh
  # Initialize brew for current shell (handles both Apple Silicon and Intel Macs)
  if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

if ! command -v git; then
  echo "Installing Git\n"
  brew install git
fi

if ! command -v npm; then
  echo "Installing Node\n"
  brew install nodejs
fi

if ! command -v pip3; then
  echo "Installing Python3\n"
  brew install python3
fi

if ! command -v bun; then
  echo "installing bun"
  curl -fsSLo /tmp/bun-install.sh https://bun.sh/install
  chmod +x /tmp/bun-install.sh
  /tmp/bun-install.sh
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi

if ! command -v pyenv; then
  echo "Installing PyEnv\n"
  brew install pyenv
fi

# This is covered in the setup.sh script
# echo "Installing Homebrew packages\n"
# xargs brew install < "$SCRIPT_DIR"/brew-packages

if ! command -v xcodebuild; then
  echo "Installing XCode CLI"
  xcode-select --install
fi

# TODO:
# echo "Installing Node packages\n"
