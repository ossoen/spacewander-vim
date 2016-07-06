#!/bin/bash

echo 'remove old version of vim'
sudo apt-get remove vim vim-runtime gvim
sudo apt-get install libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev git python python-pip libncurses5-dev
cd /tmp
git clone https://github.com/vim/vim.git --depth 1
cd vim
./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
	--enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config \
	--enable-luainterp --enable-perlinterp --enable-gui=gtk2 --enable-csope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
