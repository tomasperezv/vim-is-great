#!/bin/bash
# -----------------------------------------------------------------------------
# The following script updates vimrc and vim files to references to the
# vim-is-great project folder.
# @see https://github.com/tomasperezv/vim-is-great
# -----------------------------------------------------------------------------
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/vim $HOME/.vim
