" --> action: RECOMMENDED
" -->  group: KEYMAPS, EDITOR

" --> restore cursor after joining lines
nnoremap J mjJ`j

" --> get out of Insert mode by pressing <jj> or <jk> keys
inoremap jj <Esc>
inoremap jk <Esc>

" --> override behavious of <j> and <k> keys on long wrapped lines
noremap j gj
noremap k gk

" --> allow <tab> key to jump between matching text objects, like <%> key
nnoremap <Tab> %
vnoremap <Tab> %

" --> provide mapping to quick-close the current window
noremap <leader>wq :q<CR>
" --> provide mapping to quick-save the current buffer
nnoremap <leader>fs :w!<CR>
" --> provide mapping to save current buffer after removing/converting all whitespace
nnoremap <silent> <leader>W  mw:%s/\v<C-v><C-m>//e<CR>:retab<CR>:%s/\s\+$//e<CR>:nohlsearch<CR>:w<CR>`w
" --> provide mapping to quickly switch between the last two buffers
nnoremap <leader><leader> <C-^>
" --> provide shortcut to sudo-write the current buffer
cmap w!! w !sudo tee % >/dev/null
" --> map keys to allow editing files in the current directory quickly
map <leader>er :e **/*
map <leader>ew :e ./
map <leader>es :sp ./
map <leader>ev :vsp ./
map <leader>et :tabe ./

" --> auto-indent the current buffer
nmap <leader>b= ggVG=''
" --> indenting text in visual mode does not leave the mode
vnoremap < <gv
vnoremap > >gv
" --> map <Q> key to format the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" --> map <C-f> key to complete file names in insert mode
imap <C-f> <C-x><C-f>
" --> map <C-l> key to complete lines from current buffer in insert mode
imap <C-l> <C-x><C-l>

" --> map <F8> key to insert the current time in the buffer
nnoremap <F8> "=strftime("%d-%m-%y %H:%M:%S")<CR>P
inoremap <F8> <C-R>=strftime("%d-%m-%y %H:%M:%S")<CR>

" --> avoid accidental hits of <Shift> key
cmap Tabe tabe
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif
