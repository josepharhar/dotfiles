" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-bufferline'
"Plug 'sheerun/vim-polyglot'
"Plug 'danro/rename.vim'
"Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sleuth'
"Plug 'google/vim-maktaba'
"Plug 'google/vim-glaive'
"Plug 'google/vim-codefmt'
"Plug 'kana/vim-fakeclip'
"Plug 'rhysd/vim-clang-format'
"Plug 'Chiel92/vim-autoformat'
"Plug 'mileszs/ack.vim'
"Plug 'wlangstroth/vim-racket'
"Plug 'valloric/YouCompleteMe'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'josepharhar/vim-tmux-navigator'
if has("win32unix") " Cygwin
  Plug 'ctrlpvim/ctrlp.vim'
else " not Cygwin
  Plug 'junegunn/fzf', { 'dir': '~/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif
call plug#end()

"call glaive#Install()
""Glaive codefmt plugin[mappings]
"Glaive codefmt clang_format_executable="clang-format-3.8"
"Glaive codefmt clang_format_style="chromium"

" rhysd/vim-clang-format
"let g:clang_format#code_style = 'chromium'
" Chiel92/vim-autoformat
"let g:formatdef_cpp_style = '"clang-format -style=Chromium"'

"let g:ctrlp_follow_symlinks = 1
nnoremap <c-p> :GFiles<cr>
nnoremap <c-o> :FZF<cr>

let g:gitgutter_diff_base = 'master'
" make gitgutter do diffing faster, updatetime is 4000ms by default
set updatetime=1000

" Line numbers
"nmap <C-l> :set invnumber<CR>
set number

syntax on
set hlsearch " highlight matches for searches
set hidden   " keep other buffers 'open' instead of closing
set autoread " load files from disk when using :checktime

" Colors
set bg=dark " for white on black terminals
"set t_Co=256
"colo koehler " /usr/share/vim/vim74/colors/koehler.vim
"hi Search cterm=bold ctermbg=darkblue ctermfg=white
if &t_Co ==# '256'
  " 256 colors enabled
  " https://jonasjacek.github.io/colors/
  hi LineNr ctermbg=232 ctermfg=237
  hi Search ctermbg=20 ctermfg=white
else
  " only 16 colors
  "hi Search ctermbg=darkblue ctermfg=white
  "hi LineNr ctermfg=DarkBlue
  "hi LineNr ctermbg=DarkGray
endif

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
set wildignore+=*.class,*.swp,*/build/*,*/build*/*,*/target/*,*.o,*/node_modules/*,*/client-build/*,*.bak

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
set encoding=utf-8
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0

" Spaces and Tabs
function! SpacesPerTab(numSpaces)
  set expandtab                " Insert spaces when pressing <Tab>
  let &tabstop=a:numSpaces     " Number of spaces <Tab> characters appear as
  let &softtabstop=a:numSpaces " Number of spaces inserted when pressing <Tab>
  let &shiftwidth=a:numSpaces  " Number of spaces per indent for >>, cindent
endfunction
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
set scrolloff=13          " dont let the curser get too close to the edge
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
"set textwidth=0           " Don't wrap words by default
"set textwidth=80          " This wraps a line with a break when you reach 80 chars
set virtualedit=block     " let blocks be in virutal edit mode

au! FileType racket setl nocindent

" This causes :Files from fzf to break the UI for some reason
"" Screen settings
"" When editing a file, make screen display the name of the file you are editing
"function! SetTitle()
"  if $TERM =~ "^screen"
"    let l:title = 'vim ' . expand('%:t')
"
"    if (l:title != 'vim __Tag_List__')
"      let l:truncTitle = strpart(l:title, 0, 15)
"      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'
"    endif
"  endif
"endfunction
"" Run it every time we change buffers
"autocmd BufEnter,BufFilePost * call SetTitle()

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
