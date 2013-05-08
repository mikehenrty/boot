#!/bin/bash

SRC_DIR=~/.mikehenrty-boot

fail() {
	echo $1
	exit 1
}

#git
[[ `which git` ]] || fail "Please install git first."

#git setup
git config --global user.name "Michael Henretty"
git config --global user.email "michael.henretty@gmail.com"
git config --global color.ui auto
git config --global core.editor vim

rm -rf $SRC_DIR
mkdir -p $SRC_DIR
git clone https://github.com/mikehenrty/boot $SRC_DIR

#vim config
ln -s $SRC_DIR/.vimrc ~/.vimrc
ln -s $SRC_DIR/.vim ~/.vim
