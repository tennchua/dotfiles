#!/bin/bash

function doIt() {
	dir=~/dotfiles # dotfiles directory
	for file in $(git ls-files | grep -v README.md | grep -v bootstrap.sh | cut -d"/" -f1|uniq); do
		if [[ ( -f "$file" ) || ( -d "$file" ) ]]; then
	    	echo "Creating symlink to $file in home directory."
	    	ln -s $dir/$file ~/$file
	    fi
	done
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
# source ~/.zshrc
