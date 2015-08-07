#/bin/sh

if [ `uname -o` = "Cygwin" ]
then
    echo "setting up for Cygwin"

    echo "installing apt-cyg"
    lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg && install apt-cyg /bin

    echo "installing zsh"
    apt-cyg install zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd

    echo "installing vim"
    apt-cyg install vim

    echo "installing screen"
    apt-cyg install screen

    echo "installing git"
    apt-cyg install git
fi

echo "cloning dotfiles"
git clone https://github.com/josepharhar/dotfiles.git $HOME/dotfiles

if [ `uname -o` = "Cygwin" ]
then
    echo "installing minttyrc"
    if [ -f $HOME/.minttyrc ]
    then
        echo "found old minttyrc, backing up to .minttyrc.backup"
        mv $HOME/.minttyrc $HOME/.minttyrc.backup
    fi
    ln -s $HOME/dotfiles/minttyrc $HOME/.minttyrc
fi

echo "installing zshrc"
if [ -f $HOME/.zshrc ]
then
    echo "found old zshrc, backing up to .zshrc.backup"
    mv $HOME/.zshrc $HOME/.zshrc.backup
fi
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc

echo "installing vimrc"
if [ -f $HOME/.vimrc ]
then
    echo "found old vimrc, backing up to .vimrc.backup"
    mv $HOME/.vimrc $HOME/.vimrc.backup
fi
ln -s $HOME/dotfiles/vimrc $HOME/.vimrc

echo "installing screenrc"
if [ -f $HOME/.screenrc ]
then
    echo "found old screenrc, backing up to .screenrc.backup"
    mv $HOME/.screenrc $HOME/.screenrc.backup
fi
ln -s $HOME/dotfiles/screenrc $HOME/.screenrc

echo "installing gitconfig and gitignore"

if [ -f $HOME/.gitconfig ]
then
    echo "found old gitconfig, backing up to .gitconfig.backup"
    mv $HOME/.gitconfig $HOME/.gitconfig.backup
fi
ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
if [ -f $HOME/.gitignore_global ]
then
    echo "found old gitignore_global, backing up to .gitignore_global.backup"
    mv $HOME/.gitignore_global $HOME/.gitignore_global.backup
fi
ln -s $HOME/dotfiles/gitignore_global $HOME/.gitignore_global
