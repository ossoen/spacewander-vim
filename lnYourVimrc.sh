#!/bin/sh

# link special vimrc
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

VIMCONFIG=$1vimrc #set VIMCONFIG to XXvimrc
if [ -e $CURRENT_DIR/$VIMCONFIG ];
then
    echo "setting up symlinks, link .vimrc to $VIMCONFIG"
    lnif $CURRENT_DIR/$VIMCONFIG $HOME/.vimrc    
else
    echo "$CURRENT_DIR/$VIMCONFIG not exists!"
fi
