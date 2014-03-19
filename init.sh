#/bin/bash

apt-get install zsh tmux vim

DOTFOLDER="$HOME/.dotfiles"
DOTLIST=$(ls | egrep -v "(init.sh|README.md)")
BACKUPFOLDER=$DOTFOLDER/$(date +"%Y-%m-%d_%H:%M:%S")

test ! -d $DOTFOLDER && mkdir $DOTFOLDER
test ! -d $BACKUPFOLDER && mkdir $BACKUPFOLDER

for dotfile in $DOTLIST
do 
    mv $HOME/.$dotfile $BACKUPFOLDER/$dotfile
    ln -s $(pwd)/$dotfile $HOME/.$dotfile
done

