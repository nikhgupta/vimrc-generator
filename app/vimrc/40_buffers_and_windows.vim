" --> action: RECOMMEND
" -->  group: BASIC, DEFAULTS

" --> prefer to hide buffers instead of closing them
set hidden

" --> provide sensible split editing behaviour
set splitbelow              " puts new split windows to the bottom of the current
set splitright              " puts new vsplit windows to the right of the current
set equalalways             " split windows are always of eqal size
set switchbuf=useopen,split " use existing buffer or else split current window
set winheight=7             " squash splits or windows to a separator when minimized
set winwidth=30             " squash splits or windows to a separator when minimized
set winminheight=3          " squash splits or windows to a status bar only when minimized
set winminwidth=12          " squash splits or windows to a separator when minimized

" --> resize splits when the window is resized
augroup resize_splits
  au!
  au VimResized * :wincmd =
augroup end

" --> do not open more than 15 tabs (one tab/file) from CLI
set tabpagemax=15

" --> provide mapping and command to toggle QuickFix window using '<leader>qf'
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
nmap <silent> <leader>qf :QFix<CR>

" --> provide mappings to resize splits/windows quickly
map <C-W><C-=> <C-W>=
map <C-W><C-M> <C-W>999+<C-W>999>

" --> provide mappings for easier split navigation
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" --> provide mappings to navigate to a window and maximize it
map <C-W><C-H> <C-W>h<C-W><bar>
map <C-W><C-J> <C-W>j<C-W>_
map <C-W><C-K> <C-W>k<C-W>_
map <C-W><C-L> <C-W>l<C-W><bar>
map <C-W><C-T> <C-W>T

" --> provide mapping to switch/rotate window layouts
map <C-W><space> <C-W>t<C-W>J<C-W>t<C-W>H

" --> provide mappings to jump to a specific buffer
nnoremap <leader>el :buffers<CR>:buffer<Space>
nnoremap <leader>e3 :e#

" --> provide mapping to split, load the current buffer and switch to it
nnoremap <leader>wh <C-w>s
nnoremap <leader>wv <C-w>v<C-w>l

" --> provide mapping to split, load the previous buffer and switch to it
nnoremap <leader>ph :execute 'rightbelow split' bufname('#')<cr>
nnoremap <leader>pv :execute 'leftabove vsplit' bufname('#')<cr>

" --> speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
