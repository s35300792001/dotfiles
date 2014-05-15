#/bin/bash

if [ $(id -u) != 0 ]; then
    echo "Warning: Please run with sudo"
    exit 0
fi

apt-get install -y zsh git-core tmux vim
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

DOTFOLDER="$HOME/.dotfiles"
DOTLIST=$(ls | egrep -v "(init.sh|README.md)")
BACKUPFOLDER=$DOTFOLDER/$(date +"%Y-%m-%d_%H:%M:%S")

test ! -d $DOTFOLDER && mkdir $DOTFOLDER
test ! -d $BACKUPFOLDER && mkdir $BACKUPFOLDER

for dotfile in $DOTLIST
do
    echo "Move .$dotfile from $HOME to $BACKUPFOLDER" 
    mv $HOME/.$dotfile $BACKUPFOLDER/$dotfile
    echo "Create symbolic link .$dotfile at $HOME linking to $BACKUPFOLDER/$dotfile"
    ln -s $(pwd)/$dotfile $HOME/.$dotfile
done

chsh -s `which zsh`
shutdown -r 0

