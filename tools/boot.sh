#!/bin/bash

SRC_DIR=$HOME/.mikehenrty-boot
LN_DIR=$SRC_DIR/dotfiles

fail() {
  echo $1
  exit 1
}

# Check if this is initial install or update.
clone_or_pull() {
  if [ ! -e $2/.git ]; then
    echo "Checking out $1."
    git clone $1 $2
  else
    echo "Checking $1 for updates."
    pushd $2 && git pull origin master && popd
  fi
}

# Make sure we have git before contrinuing.
[[ `command -v git` ]] || fail "Please install git first."

# Print my welcome message.
echo $'              .---. .---. \n             :     : o   :\n         _..-:   o :     :-.._\n     .-\'\'  \'  `---\' `---\' "   ``-.    \n   .\'   "   \'  "  .    "  . \'  "  `.\n  :   \'.---.,,.,...,.,.,.,..---.  \' ;\n  `. " `.                     .\' " .\n   `.  \'`.                   .\' \' .\'\n    `.    `-._           _.-\' "  .\'  .----.\n      `. "    \'"--...--"\'  . \' .\'  .\'  o   `.\n      .\'`-._\'    " .     " _.-\'`. :       o  :\n    .\'      ```--.....--\'\'\'    \' `:_ o       :\n  .\'    "     \'         "     "   ; `.;";";";\'\n ;         \'       "       \'     . ; .\' ; ; ;\n; mikehenrty     \'       \'   "    .\'      .-\'\n\'  "     "   \'      "           "    _.-\''

echo $'\n\nSetting up your environement.'

# Check if this is initial install or update.
if [ ! -e $SRC_DIR/.git ]; then
  echo "Configuring for the first time."
  git clone https://github.com/mikehenrty/boot $SRC_DIR
else
  echo "Checking for updates."
  pushd $SRC_DIR && git pull origin master
  popd
fi

echo "Updating dotfiles."
for entry in `ls -A "$LN_DIR"`
do
  file_path=$HOME/$entry
  # Backup old dotfile if it already exists.
  [ -e $file_path ] && [ ! -L $file_path ] && mv $file_path $file_path"_backup_"`date +%Y%m%d` && echo "Created backup for "$file_path
  [ ! -e $file_path ] && ln -s $LN_DIR/$entry $HOME/$entry && echo "Created link for "$file_path
done

# Create vim undo directory.
[ ! -e $HOME/.vimundo/ ] && mkdir $HOME/.vimundo/ && echo "Created vim undo folder."

# Install fuzzy finder
clone_or_pull "https://github.com/junegunn/fzf.git" "$SRC_DIR/.fzf"
$SRC_DIR/.fzf/install

echo "Finished setting up enviroment."
