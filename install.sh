#/bin/sh

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [ `uname -o` = "Cygwin" ]; then
    echo -e "${BLUE}Setting up for ${RED}Cygwin${NC}"

    echo -e "${BLUE}Installing apt-cyg${NC}"
    lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg && install apt-cyg /bin

    echo -e "${BLUE}Installing zsh${NC}"
    apt-cyg install zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd

    echo -e "${BLUE}Installing vim${NC}"
    apt-cyg install vim

    echo -e "${BLUE}Installing screen${NC}"
    apt-cyg install screen

    echo -e "${BLUE}Installing git${NC}"
    apt-cyg install git

elif [ `uname -o` = "GNU/Linux" ]; then
    #check specific distro
    if [ -f /etc/arch-release ] ; then
        #distro is based on arch
        echo -e "${BLUE}Setting up for ${RED}Arch${NC}"

        echo -e "${BLUE}Installing zsh${NC}"
        sudo pacman -S zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd

        echo -e "${BLUE}Installing vim${NC}"
        sudo pacman -S vim

        echo -e "${BLUE}Installing screen${NC}"
        sudo pacman -S screen

        echo -e "${BLUE}Installing git${NC}"
        sudo pacman -S git

    elif [ -f /etc/debian-release ] ; then
        #distro based on debian (ubuntu)
        echo -e "${BLUE}Setting up for ${RED}debian${NC}"

        echo -e "${BLUE}Installing zsh${NC}"
        sudo apt-get install zsh && mkpasswd -c | sed -e 'sX/bashX/zshX' | tee -a /etc/passwd
        
        echo -e "${BLUE}Installing vim${NC}"
        sudo apt-get install vim

        echo -e "${BLUE}Installing screen${NC}"
        sudo apt-get install screen

        echo -e "${BLUE}Installing git${NC}"
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
