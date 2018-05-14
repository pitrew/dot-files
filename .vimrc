runtime! debian.vim

"set guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso8859-2
"set guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso8859-2
"set encoding=iso8859-2
"set fileencodings=iso8859-2
set encoding=utf-8
set fileencodings=utf-8
set termencoding=iso8859-2
" set guifont=Terminus\ 10
" set guifontwide=Terminus\ 10

colorscheme desert

if has("gui_running")
        set guioptions-=T
        set lines=100
        set columns=329
endif

set ruler
set hls
set number
set ic
filetype plugin indent on
syntax enable
set backspace=indent,eol,start
set showtabline=1
set incsearch          " Show search matches as you type
set nocompatible       " vi compatibility is weak
set autowriteall
au BufRead *.c,*.h,*.cpp set spell

map! <F1>  <Esc>
map  <F1>  <Esc>
map <F2>  :w<CR>
imap <F2>  <C-o>:w<CR>
map  <S-F2> :wa<CR>:!echo Refreshing cscope... && cscope -Rb<CR>:cs reset<CR><CR>
imap <S-F2> <C-o>:wa<CR><C-o>:!echo Refreshing cscope... && cscope -Rb<CR><C-o>:cs reset<CR><CR>
map  <F3>  :A<CR>
imap <F3>  <C-o>:A<CR>
map <F8> dd
map  <F10> @q
imap <F10> <C-o>@q
set pastetoggle=<F11>
" F12 - reserved for yakuake

" trailing whitespaces
let c_space_errors = 1
let java_space_errors = 1

map 111 i#include <><ESC>0$i
map main <C-o>i#include <stdio.h><CR><CR>int main(int argc, char *argv[])<CR>{<CR><CR>return 0;<CR>}<CR><UP><UP><UP><TAB>
map foo <C-o>iint ()<CR>{<CR><CR><TAB>return 0;<CR>}<CR><UP><UP><UP><UP><UP><ESC>0$<LEFT>i
map bar <C-o>ivoid ()<CR>{<CR><CR><TAB>return;<CR>}<CR><UP><UP><UP><UP><UP><ESC>0$<LEFT>i

map . <ESC>:n<CR>
map , <ESC>:N<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>


fun! CommentMe()
  let start = line('.')
  let line = getline(start)
  if line[0] == '/' && line[1] == '/'
          let newline = strpart(line,2)
          let offset = -2
  else
         let newline = "//" . line
         let offset = 2
  endif
  let save_pos = getpos('.')
  let save_pos[2] += offset
  echo save_pos
  call setline('.', newline)
  call setpos('.', save_pos)
endfun
map <F4> :call CommentMe()<CR>
imap <F4> <C-o>:call CommentMe()<CR>

fun! InsertBackslash() range
        for line_num in range(a:firstline, a:lastline)
                let lcont = substitute(getline(line_num), "^\\(.\\{-}\\)\\s*\\\\\\\?\\s*$", "\\1 \\", "g")
                call setline(line_num, lcont)
        endfor
endfun
map bs :call InsertBackslash()<CR>
