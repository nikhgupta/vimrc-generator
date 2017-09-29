" --> action: RECOMMEND
" -->  group: BASIC

" --> provide <Tab> key completion for paths just like Bash
set wildmenu
set wildmode=list:longest,full      " show a list when pressing tab, then longest common part and then full name.
set wildignore+=*/.hg/*,*/.svn/*    " stuff to ignore when tab completing
set wildignore+=*vim/backups*       " ...
set wildignore+=*/smarty/*          " ...
set wildignore+=*/node_modules/*    " ...
set wildignore+=*/.sass-cache/*     " ...
set wildignore+=*/tmp/*,tmp/**      " ...
set wildignore+=*/out/**,log/**     " ... phew!!
" file suffixes that can be safely ignored for file name completion
set suffixes+=.swo,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.DS_Store,.class,.so
set suffixes+=.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll,.zip
set suffixes+=.gem,.pdf,.avi,.mkv,.psd

" --> provide a fuzzy finder for files, buffers, tags, etc.
Plug 'kien/ctrlp.vim'
" notes:
"   - when CtrlP window is open:
"   : f5 will clear the CtrlP cache (useful if you add new files during the session)
"   : <C-f> & <C-b> will cycle between CtrlP modes
"   : Press <c-d> to switch to filename only search instead of full path.
"   : Press <c-r> to switch to regexp mode.
"   : Use <c-j>, <c-k> or the arrow keys to navigate the result list.
"   : Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
"   : Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
"   : Use <c-y> to create a new file and its parent directories.
"   : Use <c-z> to mark/unmark multiple files and <c-o> to open them.
"
" Set no max file limit
let g:ctrlp_max_files = 0
" Ignore files matching the following patterns
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" Store cache in this directory
let g:ctrlp_cache_dir = expand("~/.vim") . "/tmp/cache/ctrlp"
" Use pt/ag in CtrlP for listing files. Lightning fast and respects .gitignore
if executable("ag") | let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' | endif
if executable("pt") | let g:ctrlp_user_command = 'pt %s -l --nocolor -g ""' | endif
map <C-b> :CtrlPBuffer<CR>
map <C-o> :CtrlP %:p:h<CR>
nnoremap <leader>. :CtrlPTag<cr>

" --> provide a feature-rich file explorer in a sidebar
let g:netrw_silent = 1
let g:netrw_quiet  = 1
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
let NERDTreeWinPos = "left"        " nerdtree should appear on left
let NERDTreeWinSize = 25           " nerdtree window must be 25 char wide
let NERDTreeStatusLine = -1        " do not use the default status line
let NERDTreeDirArrows          = 1 " display fancy arrows instead of ASCII
let NERDTreeMinimalUI          = 0 " I don't like the minimal UI, nerdtree!
let NERDTreeShowFiles          = 1 " show files as well as dirs
let NERDTreeShowHidden         = 1 " show hidden files, too.
let NERDTreeShowBookmarks      = 1 " oh, and obvously, the bookmarks, too.
let NERDTreeCaseSensitiveSort  = 1 " sorting of files should be case sensitive
let NERDTreeRespectWildIgnore  = 1 " ignore files ignored by `wildignore`
let NERDTreeChDirMode          = 2 " change CWD when tree root is changed
let NERDTreeMouseMode          = 2 " use single click to fold/unfold dirs
let NERDTreeQuitOnOpen         = 0 " do not quit on opening a file from tree
let NERDTreeAutoDeleteBuffer   = 1 " delete buffer when deleting the file
let NERDTreeHighlightCursorline= 1 " highlight the current line in tree
let NERDTreeBookmarksFile      = expand("~/.vim") . "/tmp/bookmarks"
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_console_startup=0
" Sort NERDTree to show files in a certain order
let NERDTreeSortOrder = [ '\/$', '\.rb$', '\.php$', '\.py$',
      \ '\.js$', '\.json$', '\.css$', '\.less$', '\.sass$', '\.scss$',
      \ '\.yml$', '\.yaml$', '\.sh$', '\..*sh$', '\.vim$',
      \ '*', '.*file$', '\.example$', 'license', 'LICENSE', 'readme', 'README',
      \ '\.md$', '\.markdown$', '\.rdoc$', '\.txt$', '\.text$', '\.textile$',
      \ '\.log$', '\.info$' ]
" Don't display these kinds of files
let NERDTreeIgnore = [ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
      \ '\.so$', '\.egg$', '^\.git$', '^\.hg$', '^\.svn$', '^\.DS_Store',
      \ '\.png$', '\.jpg$', '\.jpeg$', '\.bmp$', '\.svg$', '\.gif$',
      \ '\.zip$', '\.gz$', '\.lock$', '\.swp$', '\.bak$', '\~$' ]
" mappings
nmap <leader>ntf <leader>nto<C-w>p:NERDTreeFind<CR>
nmap <leader>ntc :NERDTreeClose<CR>
nmap <leader>nto :NERDTreeFocus<CR>:vertical resize 25<CR>

