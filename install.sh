#!/usr/bin/env bash
set -ex
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"


BASEDIR="$(dirname "$0")"
cd "$BASEDIR" || exit
CURRENT_DIR=$(pwd)

lnif() {
    if [ ! -e "$2" ] ; then
        ln -s "$1" "$2"
    fi
}

sync_dir() {
    if [ -d "$HOME"/.vim/"$1" ]; then
       cp -r "$HOME"/.vim/"$1"/* "$CURRENT_DIR"/"$1"
    fi
}

echo "backing up current vim config (保存当前vim配置为xx.date的形式)"
today=$(date +%Y%m%d)
for i in "$HOME"/.vim "$HOME"/.vimrc "$HOME"/.gvimrc "$XDG_CONFIG_HOME"/nvim; do [ -e "$i" ] && [ ! -L "$i" ] && mv "$i" "$i"."$today"; done
for i in "$HOME"/.vim "$HOME"/.vimrc "$HOME"/.gvimrc "$XDG_CONFIG_HOME"/nvim; do [ -L "$i" ] && unlink "$i" ; done


echo "同步文件夹"
sync_dir backup
sync_dir swp
sync_dir undo

echo "setting up symlinks (设置链接，将.vim 和 .vimrc 分别链接到 spacewander-vim 和 spacewander-vim/vimrc)"
echo "所以不要删除上述的文件夹"
lnif "$CURRENT_DIR"/ "$HOME"/.vim
lnif "$CURRENT_DIR"/ "$XDG_CONFIG_HOME"/nvim
lnif "$CURRENT_DIR"/vimrc "$HOME"/.vimrc
lnif "$CURRENT_DIR"/vimrc "$HOME"/.gvimrc

if [ ! -e "$CURRENT_DIR"/neobundle.vim ]; then
    echo "Installing NeoBundle"
    git clone http://github.com/shougo/neobundle.vim.git "$CURRENT_DIR"/bundle/neobundle.vim
fi


echo "update/install plugins using Neobundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u "$CURRENT_DIR"/vimrc +NeoBundleInstall +qall
export SHELL=$system_shell

echo "compile YouCompleteMe"
echo "if error,you need to compile it yourself"
cd "$CURRENT_DIR"/bundle/YouCompleteMe/ || exit
./install.py --clang-completer --gocode-completer

