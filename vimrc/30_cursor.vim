" --> action: ADVANCED

" --> highlight cursor line, but do not highlight cursor column
set cursorline
set nocursorcolumn

" --> highlight columns at 80, 100 and 120 character limits
if has('syntax') | set colorcolumn=80,100,120 | endif

" --> provide toggle key for highlighting of cursor column
"   - useful for manual indentation of text
nnoremap <leader>tcc :set cursorcolumn!<CR>

" --> use a non-blinking line cursor in insert mode
Plug 'jszakmeister/vim-togglecursor'
if g:is_gui
  let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')
endif

" --> enable use of multiple cursors for quick editing
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key='<F3>'
let g:multi_cursor_prev_key=''
let g:multi_cursor_skip_key=''
let g:multi_cursor_quit_key='<Esc>'
