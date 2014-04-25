#!/bin/bash

SRC_DIR=$HOME/.mikehenrty-boot

fail() {
	echo $1
	exit 1
}

#git
[[ `which git` ]] || fail "Please install git first."

#begin setup
#echo "                          .---. .---. 
#echo "                         :     : o   :
#echo "                     _..-:   o :     :-.._
#echo "                 .-''  '  `---' `---' "   ``-.    
#echo "               .'   "   '  "  .    "  . '  "  `.
#echo "              :   '.---.,,.,...,.,.,.,..---.  ' ;
#echo "              `. " `.                     .' " .
#echo "               `.  '`.                   .' ' .'
#echo "                `.    `-._           _.-' "  .'  .----.
#echo "                  `. "    '"--...--"'  . ' .'  .'  o   `.
#echo "                  .'`-._'    " .     " _.-'`. :       o  :
#echo "                .'      ```--.....--'''    ' `:_ o       :
#echo "              .'    "     '         "     "   ; `.;";";";'
#echo "             ;         '       "       '     . ; .' ; ; ;
#echo "            ;     '         '       '   "    .'      .-'
#echo "            '  "     "   '      "           "    _.-'

#git setup
git config --global user.name "Michael Henretty"
git config --global user.email "michael.henretty@gmail.com"
git config --global color.ui auto
git config --global core.editor vim

# check if this is initial install or update
if [ ! -e $SRC_DIR/.git ]; then
	# clone the environment
	echo "configuring mikehenrty's environment for the first time"
	git clone https://github.com/mikehenrty/boot $SRC_DIR
	
	# backup existing vim configuration
	echo "backing up current vim config"
	today=`date +%Y%m%d`
	for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mkdir -p $HOME/.vim_backup_$today/ && mv $i $HOME/.vim_backup_$today; done

	# link vim configuration files
	ln -s $SRC_DIR/.vimrc $HOME/.vimrc
	ln -s $SRC_DIR/.vim $HOME/.vim

	# create vim undo directory
	mkdir $HOME/.vimundo/

else 
	echo "updating mikehenrty boot"
	cd $SRC_DIR && git pull origin master
fi
