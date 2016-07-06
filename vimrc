set hlsearch
syntax on

" Line numbers
nmap <C-l> :set invnumber<CR>

" Bold Fonts
set bg=dark

" Standard vim options
set autoindent            " always set autoindenting on
set backspace=2           " allow backspacing over everything in insert mode
set cindent               " c code indenting
set diffopt=filler,iwhite " keep files synced and ignore whitespace
set expandtab             " Get rid of tabs altogether and replace with spaces
"set foldcolumn=2          " set a column incase we need it
set foldlevel=0           " show contents of all folds
set foldmethod=indent     " use indent unless overridden
set guioptions-=m         " Remove menu from the gui
set guioptions-=T         " Remove toolbar
set hidden                " hide buffers instead of closing
set history=50            " keep 50 lines of command line history
set ignorecase            " Do case insensitive matching
set incsearch             " Incremental search
set laststatus=2          " always have status bar
set linebreak             " This displays long lines as wrapped at word boundries
set matchtime=10          " Time to flash the brack with showmatch
set nobackup              " Don't keep a backup file
set nocompatible          " Use Vim defaults (much better!)
set nofen                 " disable folds
set notimeout             " i like to be pokey
set ttimeout              " timeout on key-codes
set ttimeoutlen=100       " timeout on key-codes after 100ms
set ruler                 " the ruler on the bottom is useful
set scrolloff=1           " dont let the curser get too close to the edge
set shiftwidth=4          " Set indention level to be the same as softtabstop
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
set softtabstop=4         " Why are tabs so big?  This fixes it
"set textwidth=0           " Don't wrap words by default
"set textwidth=80          " This wraps a line with a break when you reach 80 chars
set virtualedit=block     " let blocks be in virutal edit mode
set wildmenu              " This is used with wildmode(full) to cycle options

" Screen settings
" When editing a file, make screen display the name of the file you are editing
function! SetTitle()
  if $TERM =~ "^screen"
    let l:title = 'vim ' . expand('%:t')

    if (l:title != 'vim __Tag_List__')
      let l:truncTitle = strpart(l:title, 0, 15)
      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'
    endif
  endif
endfunction
" Run it every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()

" Hex editing settings
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()
" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
