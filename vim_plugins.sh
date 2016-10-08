# pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# vim-unimpaired
if [ ! -d ~/.vim/bundle/vim-unimpaired ]; then
  git clone git://github.com/tpope/vim-unimpaired.git ~/.vim/bundle/vim-unimpaired
fi

# vim-bufferline
if [ ! -d ~/.vim/bundle/vim-bufferline ]; then
  git clone https://github.com/bling/vim-bufferline ~/.vim/bundle/vim-bufferline
fi

# vim-airline
if [ ! -d ~/.vim/bundle/vim-airline ]; then
  git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
fi
