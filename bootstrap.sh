#!/bin/bash

function doIt() {
  dir=~/dotfiles # dotfiles directory
  for file in $(git ls-files | grep -v README.md | grep -v bootstrap.sh | cut -d"/" -f1 | uniq); do
    if [[ ( -f "$file" ) || ( -d "$file" ) ]]; then
      echo "Creating symlink to $file in home directory."
      ln -sf $dir/$file ~/$file
    fi
  done
  # oh-my-zsh thems
  for file in $(git ls-files .oh-my-zsh/themes | cut -d"/" -f3 | uniq); do
    echo "Creating symlink for ~/.oh-my-zsh/themes/$file"
    ln -sf $dir/.oh-my-zsh/themes/$file ~/.oh-my-zsh/themes/$file
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
# source ~/.zshrc # this throws errors, presumably because of the #!/bin/bash at the top of this file
