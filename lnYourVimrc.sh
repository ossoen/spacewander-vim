#!/bin/sh

# link special vimrc
#BASEDIR=$(dirname $0)
#cd $BASEDIR
#CURRENT_DIR=`pwd`
CURRENT_DIR=$HOME'/github/spacewander-vim'
lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

if [ $# -gt 0 ] && [ 'ls' = $1 ];then
    # ls possible vimrc 
    ls $CURRENT_DIR | grep 'vimrc'
    exit
fi

VIMCONFIG=$1vimrc #set VIMCONFIG to XXvimrc
if [ -e $CURRENT_DIR/$VIMCONFIG ];
then
    echo "setting up symlinks, link .vimrc to $VIMCONFIG"
    lnif $CURRENT_DIR/$VIMCONFIG $HOME/.vimrc    
else
    echo "$CURRENT_DIR/$VIMCONFIG not exists!"
fi
