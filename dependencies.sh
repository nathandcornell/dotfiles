#!/bin/sh

SCRIPT_PATH=$( realpath "$0" )
SCRIPT_DIR=$( dirname "$SCRIPT_PATH" )

# Install Homebrew:
if ! command -v brew; then
  echo "Installing Homebrew\n"
  curl -fsSLo /tmp/hombrew-install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  chmod +x /tmp/hombrew-install.sh
  /tmp/hombrew-install.sh
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
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
  [ -s "/Users/nate/.bun/_bun" ] && source "/Users/nate/.bun/_bun"
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
