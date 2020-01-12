#!/bin/sh

SCRIPT_PATH=$( realpath "$0" )
SCRIPT_DIR=$( dirname "$SCRIPT_PATH" )
 
echo "Linking profile config files\n"

for filename in "$SCRIPT_DIR"/profile/*; do
  if [ "$DEBUG" = "true" ]; then
    echo "Linking $filename to $HOME/.$(basename $filename)"
  fi

  # ln -s "$filename" "$HOME"/."$(basename $filename)"
done

echo "Linking vim config\n"

if [ "$DEBUG" = "true" ]; then
  echo "Linking $SCRIPT_DIR/vim to $HOME/.vim"
fi

# ln -s "$SCRIPT_DIR"/vim "$HOME"/.vim


echo "Installing vim plugins\n"
# source "$SCRIPT_DIR"/vim/setup.sh

echo "\nDONE!\n"
echo "Create a .gitconfig-user.inc in $HOME like .gitconfig-user.inc.example"
echo " to complete your git configuration\n"
