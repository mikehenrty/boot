#!/bin/bash

fail() {
	echo $1
	exit 1
}

SRC_DIR=`pwd`

#git
[[ `which git` ]] || fail "Please install git first."

#git setup
git config --global user.name "Michael Henretty"
git config --global user.email "michael.henretty@gmail.com"
git config --global color.ui auto
git config --global core.editor vim

#vim config
ln -s $SRC_DIR/.vimrc ~/.vimrc
ln -s $SRC_DIR/.vim ~/.vim
