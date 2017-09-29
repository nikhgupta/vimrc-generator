" --> action: RECOMMEND
" -->  group: BASIC, DEFAULTS

" --> provide smart search and search as we type
set ignorecase                  " makes searches ignore case
set smartcase                   " if pattern has uppercase, be case-sensitive
set wrapscan                    " search continues after the end of file
set magic                       " use magic mode when searching/replacing
set gdefault                    " search/replace globally (on a line) by default
set incsearch                   " show search matches as you type
if g:is_gui || &t_Co > 2 | set hlsearch | endif
Plug 'vim-scripts/IndexedSearch'
nmap <silent> <leader><cr> :nohlsearch<CR>

" --> search word under cursor using <*> or <#> keys in normal/visual mode
Plug 'nelstrom/vim-visual-star-search'

" --> provide smart replace that affects multiple variants of a word
"     - supports converting to and from snake_case, camelCase, etc.
Plug 'tpope/vim-abolish'

" --> prefer `pt` or `ag` over `ack` for searching
if executable('pt')
  Plug 'rking/pt.vim'
  let g:ptprg='pt --vimgrep -S'
  set grepprg=pt\ --vimgrep\ -S
  nnoremap <leader>a :Pt <Space>
elseif executable('ag')
  Plug 'rking/ag.vim'
  let g:agprg='ag --vimgrep -S'
  set grepprg=ag\ --vimgrep\ -S
  nnoremap <leader>a :Ag <Space>
elseif executable('ack')
  Plug 'mileszs/ack.vim'
  nnoremap <leader>a :Ack --smart-case<Space>
endif

" --> provide mapping to jump to lines with word under cursor
"     FIXME: when quitting from this command via <Esc>, it takes us to the first
"            match, instead of keeping the cursor in place.
nmap <Leader>fs [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" --> provide mapping to replace word under cursor
nmap <leader>fr :%s#\<<C-r>=expand("<cword>")<CR>\>#
