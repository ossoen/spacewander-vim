#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

echo "backing up current vim config (保存当前vim配置为xx.date的形式)"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -L $i ] && unlink $i ; done


echo "setting up symlinks (设置链接，将.vim 和 .vimrc 分别链接到 spacewander-vim 和 spacewander-vim/vimrc)"
echo "所以不要删除上述的文件夹"
lnif $CURRENT_DIR/vimrc $HOME/.vimrc
lnif $CURRENT_DIR/ $HOME/.vim

lnif $CURRENT_DIR/lnYourVimrc.sh $HOME/lnYourVimrc.sh

if [ ! -e $CURRENT_DIR/neobundle.vim ]; then
    echo "Installing NeoBundle"
    git clone http://github.com/shougo/neobundle.vim.git $CURRENT_DIR/bundle/neobundle.vim
fi


echo "update/install plugins using Neobundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $CURRENT_DIR/vimrc +NeoBundleInstall +qall
export SHELL=$system_shell

#vim bk and undo dir
echo "设置备份文件夹 ~/bak/vimbk 和 ~/bak/vimundo (如有必要)"
if [ ! -d ~/bak/vimbk ]
then
    mkdir -p ~/bak/vimbk
fi

if [ ! -d ~/bak/vimundo ]
then
    mkdir -p ~/bak/vimundo
fi

echo "compile YouCompleteMe"
echo "if error,you need to compile it yourself"
cd $CURRENT_DIR/bundle/YouCompleteMe/
if [ -n "$(locate libclang.so)" ]
then
    bash -x install.sh --clang-completer --system-libclang
else
    bash -x install.sh --clang-completer
fi

