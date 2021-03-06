# vim-is-great

My vim configuration a result of ~5 years of continuous iterations.

It contains the following plugins:

- https://github.com/Lokaltog/vim-distinguished.git
- https://github.com/Raimondi/delimitMate.git
- https://github.com/SirVer/ultisnips.git
- https://github.com/Valloric/YouCompleteMe.git
- https://github.com/bling/vim-airline.git
- https://github.com/jelera/vim-javascript-syntax.git
- https://github.com/jistr/vim-nerdtree-tabs
- https://github.com/majutsushi/tagbar.git
- https://github.com/mileszs/ack.vim
- https://github.com/moll/vim-node.git
- https://github.com/nathanaelkane/vim-indent-guides.git
- https://github.com/pangloss/vim-javascript.git
  https://github.com/marijnh/tern_for_vim.git
- https://github.com/scrooloose/nerdtree.git
- https://github.com/tpope/vim-fugitive.git
- https://github.com/tpope/vim-surround.git
- https://github.com/xolox/vim-easytags
- https://github.com/xolox/vim-misc

## Requirements

```
sh configure.sh
```

### Optional: Install Node.js for javascript oriented IDE

```
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
```

### Optional: Install `eslint` for syntax check

```
sudo npm install -g eslint
```

### Optional: Install `flow` for javascript autocompletion features

``` sudo npm install -g flow-bin ```

## Setup

### Via curl

```bash
curl -sL https://raw.githubusercontent.com/tomasperezv/vim-is-great/master/curl-install.sh | bash -
```

**Note:** The script will ask you to overwrite the `$HOME/.vimrc` and `$HOME/vim` files in case they found it. They will be replaced by symbolic links to the project's folder in case you agree. Otherwise you would need to do it manually.

### Manual install

```bash
git clone git@github.com:tomasperezv/vim-is-great.git
cd vim-is-great
sh setup.sh
```

**Note:** If you want to replace the references to `$HOME/.vimrc` and `$HOME/.vim` by the references to the project you can run directly `update-home-vim.sh`

```bash
cd vim-is-great
sh update-home-vim.sh
```
