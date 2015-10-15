#/bin/sh

if [ `uname -o` = "Cygwin" ]; then
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

elif [[ 'uname' = "Linux" ]]; then
    #check specific distro
    if [ -f /etc/arch-release ] ; then
        #distro is based on arch
        echo "Setting up for Arch"

        echo "Installing zsh"
        sudo pacman -S zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd

        echo "Installing vim"
        sudo pacman -S vim

        echo "Installing screen"
        sudo pacman -S screen

        echo "Installing git"
        sudo pacman -S git

    elif [ -f /etc/debian-release ] ; then
        #distro based on debian (ubuntu)
        echo "Setting up for debian based (ubuntu)"

        echo "Installing zsh"
        sudo apt-get install zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd
        
        echo "Installing vim"
        sudo apt-get install vim

        echo "Installing screen"
        sudo apt-get install screen

        echo "Installin git"
        sudo apt-get install git

    fi
fi

echo "cloning dotfiles"
git clone https://github.com/josepharhar/dotfiles.git $HOME/dotfiles

echo "installing minttyrc"
if [ -f $HOME/.minttyrc ]
then
    echo "found old minttyrc, backing up to .minttyrc.backup"
    mv $HOME/.minttyrc $HOME/.minttyrc.backup
fi
ln -s $HOME/dotfiles/minttyrc $HOME/.minttyrc

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
