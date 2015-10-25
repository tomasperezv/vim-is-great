#!/bin/bash
# -----------------------------------------------------------------------------
# The following script initializes the vim setup.
# @see https://github.com/tomasperezv/vim-is-great
# -----------------------------------------------------------------------------
git submodule update --init --recursive
cd vim/bundle/YouCompleteMe/
./install.py
cd -
cd vim/bundle/tern_for_vim
npm install
cd -
mkdir vim/tmp
