" --> action: RECOMMENDED
" -->  group: PROGRAMMING

" --> do not break keywords on '.', '-' or '#'
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-

" --> enable syntax highting of code in a sane manner
set synmaxcol=800
" syntax highlight on, when terminal has colors
if g:is_gui || &t_Co > 2 | syntax on | endif

" --> blink matching parenthesis for a brief duration
set showmatch
set matchtime=2    " show matching parenthesis for 0.2 seconds

" --> auto-indent text by default and when writing code
set autoindent     " always set autoindenting on
set shiftwidth=2   " number of spaces to use for autoindenting
set copyindent     " copy the previous indentation on autoindenting
set shiftround     " use multiple of 'sw' when indenting with '<' and '>'
set smarttab       " insert tabs on start of line acc to 'sw' not 'ts'

" -->  auto-format comments, & insert comment markers where required
set formatoptions+=cro
set formatoptions+=q
if v:version > 730
  silent! set formatoptions+=j " remove comment markers when joining lines
endif

" --> add various plugins to help with writing code
Plug 'tpope/vim-endwise'      " add block-level end statements on auto
Plug 'kana/vim-smartinput'    " add/remove punctuation pairs when typing
Plug 'tpope/vim-commentary'   " add/remove comments for various langs
Plug 'AndrewRadev/switch.vim' " switch b/w alternate forms of code segments
Plug 'tsaleh/vim-align'       " align code segments quicker
nnoremap - :Switch<cr>

" --> add support for code tags and searching/discovering them
set tags+=./tags,tags;/         " find and load tags file up until root
nnoremap <silent> <leader>j :tnext<cr>zt
nnoremap <silent> <leader>J :tprev<cr>zt
nnoremap <silent> <leader>k :pop<cr>zt
" --> map <C-\> to view tag definition for current word in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" --> allow using multiple syntax/file types in a single file
Plug 'vim-scripts/SyntaxRange'

" --> provide projections based project-wide configurations
"     NOTE: specially, useful if using Ruby group of VIM config
Plug 'tpope/vim-projectionist'

" needed by other sections
augroup setup_whitespace | au! | augroup end
augroup exceeded_text_width | au! | augroup end
