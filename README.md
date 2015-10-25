# vim-is-great

My vim configuration

## Requirements

```
sudo apt-get install -y curl cmake python-dev git
```

### Optional: Install Node.js for javascript oriented IDE

```
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
```

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
