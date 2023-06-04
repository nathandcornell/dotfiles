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
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

echo "Installing pip 2"
python curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python

echo "Installing vim plugins\n"
source "$SCRIPT_DIR"/vim/setup.sh

echo "Linking zsh theme\n"
ln -s "$SCRIPT_DIR"/oh-my-zsh/n8.zsh-theme "$HOME"/.oh-my-zsh/themes/n8.zsh-theme

echo "Linking powerlevel 10K"
ln -s "$SCRIPT_DIR"/p10k.zsh "$HOME"/.p10k.zsh

echo "\nDONE!\n"
echo "Create a .gitconfig-user.inc in $HOME like .gitconfig-user.inc.example"
echo " to complete your git configuration\n"
