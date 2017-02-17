" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-bufferline'
Plug 'kien/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'danro/rename.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
"Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
"Plug 'google/vim-glaive'
Plug 'kana/vim-fakeclip'
Plug 'rhysd/vim-clang-format'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" rhysd/vim-clang-format
let g:clang_format#code_style = 'chromium'

" Line numbers
"nmap <C-l> :set invnumber<CR>
set number

syntax on
set hlsearch " highlight matches for searches
set bg=dark  " for white on black terminals
set hidden   " keep other buffers 'open' instead of closing
set autoread " load files from disk when using :checktime

" open all files in arglist when they are loaded to prevent E173: n more files
" to edit
" TODO fix with this
" http://stackoverflow.com/questions/9354847/concatenate-inputs-in-bash-script
if argc() > 1
  silent blast " load last buffer
  silent bfirst " switch back to the first
endif

" wildmenu
set wildchar=<Tab>
set wildmenu
"set wildmode=full " :help wildmode
"set wildmode=longest:full
set wildmode=longest:full,full
set wildignore+=*.class,*.swp,*/build/*,*/target/*,*.o,*/node_modules/*,*/deps/*

"set errorformat=%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\, line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m

"clang errorformat?
"errorformat=%f:%l:%c:\ %t%s:\ %m

" alt keybindings to switch between windows
" keybindings were discovered by pressing ctrl+v then alt+j in insert mode
"nnoremap <silent> j :wincmd j<CR>
"nnoremap <silent> h :wincmd h<CR>
"nnoremap <silent> k :wincmd k<CR>
"nnoremap <silent> l :wincmd l<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-m> :wincmd q<CR>

" ycm
nnoremap <C-i> :YcmCompleter GoTo<CR>

" Spaces and Tabs
function! SpacesPerTab(numSpaces)
  let &tabstop=a:numSpaces     " Number of spaces <Tab> characters appear as
  let &softtabstop=a:numSpaces " Number of spaces inserted when pressing <Tab>
  let &shiftwidth=a:numSpaces  " Number of spaces per indent for >>, cindent
endfunction
set expandtab                  " Insert spaces when pressing <Tab>
call SpacesPerTab(2)           " Set spaces per tab to 2 by default
" Keybindings to change # of spaces per tab
:map T2 :call SpacesPerTab(2)<CR>
:map T3 :call SpacesPerTab(3)<CR>
:map T4 :call SpacesPerTab(4)<CR>
:map T<Tab> :set noexpandtab<CR>


" Standard vim options
set autoindent            " always set autoindenting on
set backspace=2           " allow backspacing over everything in insert mode
set cindent               " c code indenting
set diffopt=filler,iwhite " keep files synced and ignore whitespace
"set foldcolumn=2          " set a column incase we need it
set foldlevel=0           " show contents of all folds
set foldmethod=indent     " use indent unless overridden
set guioptions-=m         " Remove menu from the gui
set guioptions-=T         " Remove toolbar
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
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
"set textwidth=0           " Don't wrap words by default
"set textwidth=80          " This wraps a line with a break when you reach 80 chars
set virtualedit=block     " let blocks be in virutal edit mode

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
"nnoremap <C-H> :Hexmode<CR>
"inoremap <C-H> <Esc>:Hexmode<CR>
"vnoremap <C-H> :<C-U>Hexmode<CR>
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

" Google
"set makeprg=ninc

" this causes CSL server with older vim to open terminal after opening vim
"set shellcmdflag=-ic " interactive shell so ninc will get aliased

"let g:airline_left_sep = '▶' " Unmodded powerline character
"let g:airline_left_sep = '' " Modded powerline character
let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif

filetype plugin indent on " for eclim

"let g:EclimCompletionMethod = 'omnifunc'

" CPE 471 config
se tags+=$HOME/glm/tags

let g:ctrlp_working_path_mode = ''

" Maven
set makeprg=mvn\ compile
set errorformat=[ERROR]\ %f:[%l\\,%v]\ %m

" TODO :noh temporarily disables hlsearch until next search, make a keybinding pls
"set clipboard=unnamedplus
set clipboard=unnamed
