#!/bin/bash
# -----------------------------------------------------------------------------
# The following script updates vimrc and vim home files to references to the
# vim-is-great project folder.
# @see https://github.com/tomasperezv/vim-is-great
# -----------------------------------------------------------------------------

## Step 1: Clone the repo and setup
git clone git@github.com:tomasperezv/vim-is-great.git
cd $PWD/vim-is-great
#sh setup.sh

## Step 2: Update the .vimrc and .vim files
echo "$HOME/.vimrc"
if [ -e "$HOME/.vimrc" ]
then
  while true; do
    read -p "$HOME/.vimrc found, do you want to overwrite it? [y/N]: " yn
    case $yn in
      [Yy]* )
        echo "Back up $HOME/.vimrc to $HOME/.vimrc.bak"
        mv $HOME/.vimrc $HOME/.vimrc.bak
        echo "Generating $HOME/.vimrc"
        ln -s $PWD/vimrc $HOME/.vimrc
        break;;
      [Nn]* )
        echo 'Skipping...'
        break;;
      * )
        echo 'Skipping...'
        break;;
    esac
  done
else
  echo "Generating $HOME/.vimrc"
  ln -s $PWD/vimrc $HOME/.vimrc
fi

if [ -e "$HOME/.vim" ]
then
  while true; do
    read -p "$HOME/.vim found, do you want to overwrite it? [y/N]: " yn
    case $yn in
      [Yy]* )
        echo "Back up $HOME/.vim to $HOME/.vim.bak"
        mv $HOME/.vim $HOME/.vim.bak
        echo "Generating $HOME/.vim"
        ln -s $PWD/vim $HOME/.vim
        break;;
      [Nn]* )
        echo 'Skipping...'
        break;;
      * )
        echo 'Skipping...'
        break;;
    esac
  done
else
  echo "Generating $HOME/.vim"
  ln -s $PWD/vim $HOME/.vim
fi
