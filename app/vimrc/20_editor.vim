" --> action: RECOMMEND
" -->  group: EDITOR, DEFAULTS, BASIC

" --> allow cursor 1 char beyond end of current line
set virtualedit=onemore

" --> allow backspace to work over everything in Insert mode
set backspace=indent,eol,start

" --> try different EOL formats when reading buffers
set fileformats="unix,dos,mac"

" --> set basic formatting options for editing text
set formatoptions-=t            " do not format just about any type of text, esp. source code
set formatoptions+=n            " recognize numbered lists when formatting
set formatoptions+=1            " don't break a line after a one-letter word

" --> use soft tabs (with spaces) over hard tabs
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when <BS>, pretend tab is removed, even if spaces
set expandtab                   " expand tabs, by default
set nojoinspaces                " prevents two spaces after punctuation on join

" --> disable wrapping of long lines and set line width to 80 characters
set nowrap                      " don't wrap lines
set linebreak                   " break long lines at words, when wrap is on
set whichwrap=b,s,h,l,<,>,[,]   " allow <BS> & cursor keys to move to prev/next line
set showbreak=↪                 " string to put at the starting of wrapped lines
set textwidth=80                " wrap after this many characters in a line

" --> display any whitespace in the buffer
set list                        " show invisible characters like spaces
                                " enabled later via autocmd on certain filetypes
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:·

" --> provide movement around surroundings of text object
Plug 'tpope/vim-surround'
" --> provide fast jumps to any specific location - try ,,w
Plug 'Lokaltog/vim-easymotion'

" --> allow creation of our own text objects, and add some useful ones
Plug 'kana/vim-textobj-user'
Plug 'austintaylor/vim-indentobject'      " indentations: i
Plug 'coderifous/textobj-word-column.vim' " vertical columns by word boundary: c
Plug 'kana/vim-textobj-fold'              " foldings: z
