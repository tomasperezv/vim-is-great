#!/bin/bash
# -----------------------------------------------------------------------------
# @see https://github.com/tomasperezv/vim-is-great
# -----------------------------------------------------------------------------
folder='./vim/bundle/'
submodules_count=$(find $folder -maxdepth 1 -not -path $folder -type d | wc -l)
counter=1
for dir in ./vim/bundle/*/
do
  echo '## Updating' $counter 'of' $submodules_count '('$dir')'
  cd $dir
  git branch
  git pull
  git checkout master
  cd -
  counter=$((counter+1))
done
