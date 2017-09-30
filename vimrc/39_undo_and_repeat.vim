" --> action: RECOMMENDED

" --> persist undo/redo history even after closing a file
if has('persistent_undo')
  set undofile                  " have a long persisting undo data
  set undolevels=1000           " Maximum number of changes that can be undone
  set undoreload=10000          " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/tmp/undo,/tmp
endif

" --> provide mapping to traverse undo/redo history as a graphical tree
Plug 'sjl/gundo.vim'
nnoremap <leader>tgu :GundoToggle<CR>

" --> repeat operator <.> works with plugins and with visual selection
"     - supports plugins: commentary, surround, abolish, unimpaired
"     - read: http://stackoverflow.com/a/8064607/127816
Plug 'tpope/vim-repeat'
vnoremap . :normal .<CR>

" --> bring the cursor back when repeat command is finished
nmap . .`[
