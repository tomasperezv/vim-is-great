#!/bin/bash
# -----------------------------------------------------------------------------
# @see https://github.com/tomasperezv/vim-is-great
# -----------------------------------------------------------------------------
for dir in ./vim/bundle/*/
do
  echo $dir
  cd $dir
  git branch
  git pull
  git checkout master
  cd -
done
