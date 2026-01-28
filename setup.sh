#!/bin/sh

SCRIPT_PATH=$( realpath "$0" )
SCRIPT_DIR=$( dirname "$SCRIPT_PATH" )
DEBUG=$1
 
echo "Linking profile config files\n"

for filename in "$SCRIPT_DIR"/profile/*; do
  if [ "$DEBUG" = "true" ]; then
    echo "Linking $filename to $HOME/.$(basename $filename)"
  fi

  ln -s "$filename" "$HOME"/."$(basename $filename)"
done
 
echo "Linking bin scripts\n"

if [ ! -d "$HOME"/bin ]; then
  mkdir "$HOME"/bin
fi

for filename in "$SCRIPT_DIR"/bin/*; do
  if [ "$DEBUG" = "true" ]; then
    echo "Linking $filename to $HOME/bin/$(basename $filename)"
  fi

  ln -s "$filename" "$HOME"/bin/"$(basename $filename)"
done

echo "Linking vim config\n"

if [ "$DEBUG" = "true" ]; then
  echo "Linking $SCRIPT_DIR/vim to $HOME/.vim"
fi

ln -s "$SCRIPT_DIR"/vim "$HOME"/.vim

BREW_PACKAGE_LIST="$SCRIPT_DIR/brew-packages"
BREW_PACKAGES="$( cat $BREW_PACKAGE_LIST | tr '\n' ' ')"

echo "Installing utils with homebrew"
brew install $BREW_PACKAGES

echo "Linking JDK"
# Handle both Apple Silicon (/opt/homebrew) and Intel (/usr/local) Macs
if [ -d "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk" ]; then
  sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
elif [ -d "/usr/local/opt/openjdk/libexec/openjdk.jdk" ]; then
  sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
else
  echo "Warning: OpenJDK not found. Install it with: brew install openjdk"
fi

echo "Installing vim plugins\n"
source "$SCRIPT_DIR"/vim/setup.sh

if ! [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh\n"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
fi

echo "Linking custom zsh theme\n"
ln -s "$SCRIPT_DIR"/oh-my-zsh/n8.zsh-theme "$HOME"/.oh-my-zsh/themes/n8.zsh-theme

echo "\nDONE!\n"
echo "Create a .gitconfig-user.inc in $HOME like .gitconfig-user.inc.example"
echo " to complete your git configuration\n"
