""
"" Thanks to: Mislav Marohnic
""

set nocompatible
syntax enable
set encoding=utf-8

call pathogen#infect()
filetype plugin on
filetype plugin indent on

" set background=dark
colorscheme molokai
let g:molokai_original = 0
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

"" Linenumbers please
set number

"" Whitespace & indent
set wrap                          " wrap lines
set softtabstop=4                 " a tab is 4 spaces
set shiftwidth=4                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set ai                            "Auto indent
set si                            "Smart indent
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the first column when wrap is
" off and the line continues beyond the left of the screen
"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
set relativenumber

function s:setupWrapping()
    set wrap
    set wrapmargin=2
    set textwidth=72
endfunction

if has("autocmd")
    " In Makefiles, use real tabs, not tabs expanded to spaces
    au FileType make set noexpandtab

    " Make sure all markdown files have the correct filetype set and setup wrapping
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

    " Treat JSON files like JavaScript
    au BufNewFile,BufRead *.json set ft=javascript

    " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
    au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

    " Remember last location in file, but not for commit messages.
    " see :help last-position-jump
    au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif

" provide some context when editing
set scrolloff=3

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Leaderkey to ,
let mapleader=","

map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" Wildmenu
if has("wildmenu")
set wildignore+=*.rbc,*.scssc,*.sassc,*.eot,*.ttf,*.woff,.sass-cache,.out
set wildignore+=.DS_Store,.git,.hg,.svn,node_modules,img,images
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.svg
endif

" jump between two last opened buffers with ,,
nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" fast way to create new split
nnoremap <leader>w <C-w>v<C-w>l

" disable cursor keys & fix behaviour
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

    " Start the status line
    set statusline=%f\ %m\ %r

    " Add fugitive
    set statusline+=%{fugitive#statusline()}

    " Finish the statusline
    set statusline+=\ Line:%l/%L[%p%%]
    set statusline+=\ Col:%v
    set statusline+=\ Buf:#%n
    set statusline+=\ [%b][0x%B]
endif

let g:CommandTMaxHeight=10

let &t_Co=256

" Remove white spaces when saving
autocmd BufWritePre * :%s/\s\+$//e

" show filename in terminal
set t_ts=^[]1;
set t_fs=^G

" Zencoding
let g:user_zen_leader_key = '<c-k>'

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q!<cr>

" No backup
set nobackup
set nowb
set noswapfile

" Use the arrows to switch between buffers
map <right> :bn<cr>
map <left> :bp<cr>

" Allow jk & jj to work as escape
:imap jk <Esc>
:imap jj <Esc>

" PHP syntax check
nmap <leader>p :!php -l %<CR>

" Go back to command mode when focus is lost
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" Set swaps & backups location
set directory=~/.vim/swaps
set backupdir=~/.vim/backups

" Disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Persistent undo
set undodir=~/.vim_runtime/undodir
set undofile

" Match brackets with tab
nnoremap <tab> %
vnoremap <tab> %
