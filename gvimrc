color molokai
set guifont=Inconsolata\ Regular:h14
set linespace=2
set antialias

" Don't beep
set visualbell

set guioptions-=T   " No toolbar
" set guioptions-=r   " No scrollbars

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
end

" Allow jk to work as escape
:imap jk <Esc>
